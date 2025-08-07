import '../entities/item.dart';

abstract class ItemsRepository {
  /// Fetches items from the API
  Future<List<Item>> getItems();

  /// Toggles the favorite status of an item
  Future<void> toggleFavorite(String itemId);

  /// Gets the list of favorite item IDs from local storage
  Future<List<String>> getFavoriteIds();

  /// Saves the list of favorite item IDs to local storage
  Future<void> saveFavoriteIds(List<String> favoriteIds);
}
