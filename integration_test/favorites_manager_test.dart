import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../lib/favorites_manager.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await FavoritesManager.init();
  });

  group('FavoritesManager Tests', () {
    test('Toggle favorite should add and remove url correctly', () async {
      const testUrl = 'https://example.com';

      await FavoritesManager.toggleFavorite(testUrl);
      expect(FavoritesManager.isFavorite(testUrl), true);

      await FavoritesManager.toggleFavorite(testUrl);
      expect(FavoritesManager.isFavorite(testUrl), false);
    });

    test('Get favorites should return updated list after toggling favorites', () async {
      const testUrl1 = 'https://example.com/1';
      const testUrl2 = 'https://example.com/2';

      await FavoritesManager.toggleFavorite(testUrl1);
      await FavoritesManager.toggleFavorite(testUrl2);
      var favorites = FavoritesManager.getFavorites();
      expect(favorites, containsAll([testUrl1, testUrl2]));

      await FavoritesManager.toggleFavorite(testUrl1);
      favorites = FavoritesManager.getFavorites();
      expect(favorites, isNot(contains(testUrl1)));
      expect(favorites, contains(testUrl2));
    });
  });
}
