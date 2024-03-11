import 'package:flutter/material.dart';
import 'favorites_manager.dart';
import 'api_service.dart';
import 'article.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late Future<List<Article>> _futureFavorites;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  _loadFavorites() async {
    final articles = await ApiService().fetchTopHeadlines();
    final favoritesUrls = FavoritesManager.getFavorites();
    final favorites = articles
        .where((article) => favoritesUrls.contains(article.url))
        .toList();

    setState(() {
      _futureFavorites = Future.value(favorites);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: FutureBuilder<List<Article>>(
        future: _futureFavorites,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final article = snapshot.data![index];
                return ListTile(
                  title: Text(article.title),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(article: article),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No favorites added'));
          }
        },
      ),
    );
  }
}
