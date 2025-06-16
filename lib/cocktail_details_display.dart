import 'package:flutter/material.dart';
import 'package:n_s_v_d/cocktail.dart'; // Import der Cocktail-Klasse

/// A widget to display the detailed information of a single cocktail.
/// Dieses Widget zeigt die detaillierten Informationen eines einzelnen Cocktails an.
class CocktailDetailsDisplay extends StatelessWidget {
  /// The cocktail object containing all details to be displayed.
  /// Das Cocktail-Objekt, das alle anzuzeigenden Details enthält.
  final Cocktail cocktail;

  /// Constructor for CocktailDetailsDisplay.
  /// Konstruktor für CocktailDetailsDisplay.
  const CocktailDetailsDisplay({super.key, required this.cocktail});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Cocktail name
        Text(
          cocktail.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrangeAccent,
            decoration: TextDecoration.underline,
            decorationColor: Colors.deepOrangeAccent,
            decorationThickness: 2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Cocktail image
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            cocktail.imageURL,
            width: 250,
            height: 250,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value:
                      loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          ),
        ),
        const SizedBox(height: 16),
        // Glass type
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.lightGreenAccent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Glastyp: ${cocktail.glassType}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 8),
        // Ingredients
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.limeAccent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '''Zutaten: ${cocktail.ingridients}''',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        // Instructions
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.cyanAccent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            cocktail.instructions,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
