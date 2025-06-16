import 'package:flutter/material.dart';
import 'package:n_s_v_d/cocktail.dart';
import 'package:n_s_v_d/cocktail_service.dart';
import 'package:n_s_v_d/shimmer_placeholder.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Future<Cocktail> _cocktail;

  @override
  void initState() {
    super.initState();

    _cocktail = Future.delayed(const Duration(seconds: 3), () {
      return CocktailService().getRandomCocktail();
    });
  }

  void _refreshCocktail() {
    setState(() {
      _cocktail = Future.delayed(const Duration(seconds: 3), () {
        return CocktailService().getRandomCocktail();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _refreshCocktail,
          child: const Icon(Icons.refresh),
        ),

        appBar: AppBar(
          title: const Text(
            'Zufälliger Cocktail',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 64, 236),
        ),

        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/cocktail.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: FutureBuilder<Cocktail>(
                    future: _cocktail,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const ShimmerPlaceholder();
                      } else if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data!.name,
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

                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                snapshot.data!.imageURL,
                                width: 250,
                                height: 250,
                                fit: BoxFit.cover,
                                loadingBuilder: (
                                  context,
                                  child,
                                  loadingProgress,
                                ) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
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

                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.lightGreenAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Glastyp: ${snapshot.data!.glassType}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.limeAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '''Zutaten: ${snapshot.data!.ingridients}''',
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 8),

                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.cyanAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                snapshot.data!.instructions,
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          "Fehler: ${snapshot.error}",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
