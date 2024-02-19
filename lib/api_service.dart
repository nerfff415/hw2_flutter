import 'dart:convert';
import 'package:http/http.dart' as http;
import 'article.dart';

class ApiService {
  final String _baseUrl = 'https://newsapi.org/v2';
  final String _apiKey =
      'b26de14f8a654fcc82c8e90cc62ee2cb'; // Замените на ваш API-ключ от NewsAPI

  Future<List<Article>> fetchTopHeadlines() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/top-headlines?country=us&apiKey=$_apiKey'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> articlesJson = json['articles'];
      List<Article> articles = articlesJson
          .map((articleJson) => Article.fromJson(articleJson))
          .toList();
      return articles;
    } else {
      // Обработка ошибок или неудачного статуса ответа
      throw Exception('Failed to load top headlines');
    }
  }
}
