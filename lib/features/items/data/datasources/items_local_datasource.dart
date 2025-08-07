import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ItemsLocalDataSource {
  Future<List<String>> getFavoriteIds();
  Future<void> saveFavoriteIds(List<String> favoriteIds);
}

class ItemsLocalDataSourceImpl implements ItemsLocalDataSource {
  static const String _favoriteIdsKey = 'favorite_ids';

  @override
  Future<List<String>> getFavoriteIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoriteIdsJson = prefs.getString(_favoriteIdsKey);

      if (favoriteIdsJson != null) {
        final List<dynamic> jsonList = json.decode(favoriteIdsJson);
        return jsonList.cast<String>();
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveFavoriteIds(List<String> favoriteIds) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoriteIdsJson = json.encode(favoriteIds);
      await prefs.setString(_favoriteIdsKey, favoriteIdsJson);
    } catch (e) {
      throw Exception('Failed to save favorite ids: $e');
    }
  }
}
