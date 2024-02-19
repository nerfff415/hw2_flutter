import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String content;
  final String articleUrl;

  DetailsScreen({
    required this.title,
    required this.imageUrl,
    required this.content,
    required this.articleUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            imageUrl.isNotEmpty
                ? Image.network(imageUrl, fit: BoxFit.cover)
                : SizedBox(
                    height: 200,
                    child: Center(child: Text('No Image Available'))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title, style: Theme.of(context).textTheme.headline6),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(content.isEmpty ? 'No content available' : content),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
              child: ElevatedButton(
                onPressed: () => _launchURL(articleUrl),
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
