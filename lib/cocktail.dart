class Cocktail {
  String name;
  String imageURL;
  String instructions;
  String ingridients;
  String glassType;

  Cocktail({
    required this.ingridients,
    required this.glassType,
    required this.name,
    required this.imageURL,
    required this.instructions,
  });

  factory Cocktail.fromJson(Map<String, dynamic> json) {
    return Cocktail(
      name: json['strDrink'] as String,
      imageURL: json['strDrinkThumb'] as String,
      instructions: json['strInstructionsDE'] as String,
      glassType: json['strGlass'] as String,
      ingridients:
          '${json['strIngredient1']}, ${json['strIngredient2']}, ${json['strIngredient3']}, ${json['strIngredient4']}, ${json['strIngredient5']}, ${json['strIngredient6']}, ${json['strIngredient7']}, ${json['strIngredient8']}, ${json['strIngredient9']}, ${json['strIngredient10']}'
              .replaceAll('null', '')
              .replaceAll(RegExp(r',\s*$'), '')
              .replaceAll(RegExp(r',\s*,\s*'), ', '),
    );
  }
}
