import 'package:flutter/material.dart';
import 'api_service.dart';
import 'article.dart';
import 'details_screen.dart';
import 'favorites_manager.dart'; // Убедитесь, что создали и импортировали FavoritesManager

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Article>> _futureArticles;

  @override
  void initState() {
    super.initState();
    _futureArticles = ApiService().fetchTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: FutureBuilder<List<Article>>(
        future: _futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Article article = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: article.urlToImage.isNotEmpty
                        ? Image.network(article.urlToImage,
                            width: 100, fit: BoxFit.cover)
                        : null,
                    title: Text(article.title),
                    trailing: IconButton(
                      icon: Icon(FavoritesManager.isFavorite(article.url)
                          ? Icons.favorite
                          : Icons.favorite_border),
                      color: FavoritesManager.isFavorite(article.url)
                          ? Colors.red
                          : null,
                      onPressed: () async {
                        await FavoritesManager.toggleFavorite(article.url);
                        setState(() {});
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(article: article),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
