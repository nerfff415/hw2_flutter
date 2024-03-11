import 'package:shared_preferences/shared_preferences.dart';

class FavoritesManager {
  static SharedPreferences? _preferences;

  static const _keyFavorites = 'favorites';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future toggleFavorite(String url) async {
    final favorites = getFavorites();

    if (favorites.contains(url)) {
      favorites.remove(url);
    } else {
      favorites.add(url);
    }

    await _preferences?.setStringList(_keyFavorites, favorites);
  }

  static List<String> getFavorites() {
    return _preferences?.getStringList(_keyFavorites) ?? [];
  }

  static bool isFavorite(String url) {
    final favorites = getFavorites();
    return favorites.contains(url);
  }
}
