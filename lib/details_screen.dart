import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'article.dart';
import 'favorites_manager.dart'; // Убедитесь, что создали и импортировали FavoritesManager

class DetailsScreen extends StatelessWidget {
  final Article article;

  DetailsScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(FavoritesManager.isFavorite(article.url)
                ? Icons.favorite
                : Icons.favorite_border),
            color: FavoritesManager.isFavorite(article.url) ? Colors.red : null,
            onPressed: () async {
              await FavoritesManager.toggleFavorite(article.url);
              // Обновление состояния может потребовать дополнительной логики
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            article.urlToImage.isNotEmpty
                ? Image.network(article.urlToImage, fit: BoxFit.cover)
                : SizedBox(
                    height: 200,
                    child: Center(child: Text('No Image Available'))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(article.title,
                  style: Theme.of(context).textTheme.headline6),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(article.content.isEmpty
                  ? 'No content available'
                  : article.content),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
              child: ElevatedButton(
                onPressed: () => _launchURL(article.url),
                child: Text('Read full article'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
