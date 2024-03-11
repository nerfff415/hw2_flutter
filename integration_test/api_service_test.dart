import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../lib/api_service.dart'; // Убедитесь, что путь к ApiService корректный
import '../lib/article.dart'; // Убедитесь, что путь к Article корректный

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('ApiService Tests', () {
    test('fetchTopHeadlines returns list of articles on successful response', () async {
      ApiService apiService = ApiService();
      expect(await apiService.fetchTopHeadlines(), isA<List<Article>>());
    });
  });
}
