import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:n_s_v_d/cocktail.dart';

class CocktailService {
  final baseURL = "https://www.thecocktaildb.com/api/json/v1/1/random.php";

  Future<Cocktail> getRandomCocktail() async {
    final response = await http.get(Uri.parse(baseURL));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final cocktailJson = data["drinks"][0] as Map<String, dynamic>;
      return Cocktail.fromJson(cocktailJson);
    } else {
      throw Exception('Failed to load Cocktail');
    }
  }
}
