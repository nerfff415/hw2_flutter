import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../lib/api_service.dart';
import '../lib/article.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('fetchTopHeadlines', () {
    test('returns a List of Article if the http call completes successfully', () async {
      final client = MockClient();
      ApiService apiService = ApiService();
      when(client.get(
          Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=b26de14f8a654fcc82c8e90cc62ee2cb'),
          headers: anyNamed('headers')
      )).thenAnswer((_) async => http.Response('{"articles": [{"title": "Test Article", "description": "This is a test"}]}', 200));

      expect(await apiService.fetchTopHeadlines(), isA<List<Article>>());
    });
    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      ApiService apiService = ApiService();
      when(client.get(
          Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=b26de14f8a654fcc82c8e90cc62ee2cb'),
          headers: anyNamed('headers')
      )).thenAnswer((_) async => http.Response('Not Found', 404));
      expect(apiService.fetchTopHeadlines(), throwsException);
    });
  });
}
