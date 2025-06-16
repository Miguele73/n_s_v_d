import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:n_s_v_d/cocktail.dart';

class CocktailService {
  final String _baseURL = 'https://www.thecocktaildb.com/api/json/v1/1';

  Future<Cocktail> getRandomCocktail() async {
    final response = await http.get(Uri.parse('$_baseURL/random.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Cocktail.fromJson(data['drinks'][0]);
    } else {
      throw Exception('Fehler beim Laden des zufälligen Cocktails');
    }
  }

  Future<List<String>> getCocktailCategories() async {
    final response = await http.get(Uri.parse('$_baseURL/list.php?c=list'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final categories =
          (data['drinks'] as List)
              .map((e) => e['strCategory'] as String)
              .toList();
      return categories;
    } else {
      throw Exception('Fehler beim Laden der Kategorien');
    }
  }

  Future<Cocktail> getRandomCocktailByCategory(String category) async {
    final filterResponse = await http.get(
      Uri.parse('$_baseURL/filter.php?c=$category'),
    );
    if (filterResponse.statusCode == 200) {
      final filterData = json.decode(filterResponse.body);
      final drinks = filterData['drinks'] as List;

      if (drinks.isEmpty) {
        throw Exception(
          'Keine Cocktails für diese Kategorie gefunden: $category',
        );
      }

      final randomDrinkId = drinks[Random().nextInt(drinks.length)]['idDrink'];

      final lookupResponse = await http.get(
        Uri.parse('$_baseURL/lookup.php?i=$randomDrinkId'),
      );
      if (lookupResponse.statusCode == 200) {
        final lookupData = json.decode(lookupResponse.body);
        if (lookupData['drinks'] == null || lookupData['drinks'].isEmpty) {
          throw Exception(
            'Details für Cocktail-ID nicht gefunden: $randomDrinkId',
          );
        }
        final cocktailData = lookupData['drinks'][0];
        return Cocktail.fromJson(cocktailData);
      } else {
        throw Exception(
          'Fehler beim Laden der Cocktail-Details für ID: $randomDrinkId',
        );
      }
    } else {
      throw Exception(
        'Fehler beim Laden der Cocktails für Kategorie: $category',
      );
    }
  }
}
