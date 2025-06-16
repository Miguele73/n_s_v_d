import 'package:flutter/material.dart';
import 'package:n_s_v_d/category_selection_page.dart';
import 'package:n_s_v_d/cocktail.dart';
import 'package:n_s_v_d/cocktail_details_display.dart';
import 'package:n_s_v_d/cocktail_service.dart';
import 'package:n_s_v_d/shimmer_placeholder.dart';

enum AppPage { categories, cocktailDetails }

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AppPage _currentPage = AppPage.categories;

  String? _selectedCategory;

  Future<Cocktail>? _cocktail;

  @override
  void initState() {
    super.initState();
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _currentPage = AppPage.cocktailDetails;

      _cocktail = Future.delayed(const Duration(seconds: 3), () {
        return CocktailService().getRandomCocktailByCategory(category);
      });
    });
  }

  void _navigateToCategories() {
    setState(() {
      _currentPage = AppPage.categories;
      _selectedCategory = null;
    });
  }

  void _refreshCurrentCategoryCocktail() {
    if (_selectedCategory != null) {
      setState(() {
        _cocktail = Future.delayed(const Duration(seconds: 3), () {
          return CocktailService().getRandomCocktailByCategory(
            _selectedCategory!,
          );
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle = 'Zufälliger Cocktail';
    if (_currentPage == AppPage.categories) {
      appBarTitle = 'Cocktail Kategorien';
    } else if (_selectedCategory != null) {
      appBarTitle = _selectedCategory!;
    }

    return MaterialApp(
      home: Scaffold(
        floatingActionButton:
            _currentPage == AppPage.categories
                ? null
                : FloatingActionButton(
                  onPressed: _refreshCurrentCategoryCocktail,
                  backgroundColor: const Color.fromARGB(255, 255, 64, 236),
                  enableFeedback: true,
                  child: const Icon(Icons.refresh),
                ),
        appBar: AppBar(
          title: Text(appBarTitle, style: const TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 255, 64, 236),

          leading:
              _currentPage == AppPage.cocktailDetails
                  ? IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: _navigateToCategories,
                  )
                  : null,
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

            _currentPage == AppPage.categories
                ? CategorySelectionPage(onCategorySelected: _onCategorySelected)
                : SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: FutureBuilder<Cocktail>(
                        future: _cocktail,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const ShimmerPlaceholder();
                          } else if (snapshot.hasData) {
                            return CocktailDetailsDisplay(
                              cocktail: snapshot.data!,
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
