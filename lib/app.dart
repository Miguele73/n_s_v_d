import 'package:flutter/material.dart';
import 'package:n_s_v_d/cocktail.dart';
import 'package:n_s_v_d/cocktail_service.dart';

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
    _cocktail = CocktailService().getRandomCocktail();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Random Cocktail'),
          backgroundColor: const Color.fromARGB(255, 255, 64, 236),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Expanded(
              child: FutureBuilder<Cocktail>(
                future: _cocktail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.data!.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrangeAccent,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.deepOrangeAccent,

                            decorationThickness: 2,
                          ),
                        ),
                        Image.network(snapshot.data!.imageURL),
                        Container(
                          color: Colors.lightGreenAccent,
                          child: Text(
                            'Glass Type: ${snapshot.data!.glassType}',
                          ),
                        ),
                        Container(
                          color: Colors.limeAccent,
                          child: Text(
                            '''Ingredients: ${snapshot.data!.ingridients}''',
                          ),
                        ),
                        Container(
                          color: Colors.cyanAccent,
                          child: Text(snapshot.data!.instructions),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _cocktail = CocktailService().getRandomCocktail();
            });
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
