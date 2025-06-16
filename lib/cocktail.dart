class Cocktail {
  String name;
  String imageURL;
  String instructions;
  String ingridients;
  String glassType;
  String measures;

  Cocktail({
    required this.measures,
    required this.ingridients,
    required this.glassType,
    required this.name,
    required this.imageURL,
    required this.instructions,
  });

  factory Cocktail.fromJson(Map<String, dynamic> json) {
    List<String> ingredientsAndMeasures = [];

    for (int i = 1; i <= 15; i++) {
      final ingredient = json['strIngredient$i'] as String?;
      final measure = json['strMeasure$i'] as String?;

      if (ingredient != null && ingredient.isNotEmpty) {
        if (measure != null && measure.isNotEmpty) {
          ingredientsAndMeasures.add('${measure.trim()} ${ingredient.trim()}');
        } else {
          ingredientsAndMeasures.add(ingredient.trim());
        }
      }
    }

    String cleanedIngredients = ingredientsAndMeasures
        .where((s) => s.isNotEmpty)
        .join(', ');

    return Cocktail(
      name: json['strDrink'] as String,
      imageURL: json['strDrinkThumb'] as String,
      instructions: json['strInstructionsDE'] as String,
      glassType: json['strGlass'] as String,
      ingridients: cleanedIngredients,
      measures: '',
    );
  }
}
