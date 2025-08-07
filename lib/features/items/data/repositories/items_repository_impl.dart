import '../../domain/entities/item.dart';
import '../../domain/repositories/items_repository.dart';
import '../datasources/items_api_datasource.dart';
import '../datasources/items_local_datasource.dart';
import '../models/item_model.dart';

class ItemsRepositoryImpl implements ItemsRepository {
  final ItemsApiDataSource apiDataSource;
  final ItemsLocalDataSource localDataSource;

  const ItemsRepositoryImpl({required this.apiDataSource, required this.localDataSource});

  @override
  Future<List<Item>> getItems() async {
    try {
      // Get items from API
      final List<ItemModel> itemModels = await apiDataSource.getItems();

      // Get favorite IDs from local storage
      final List<String> favoriteIds = await localDataSource.getFavoriteIds();

      // Convert models to entities with favorite status
      return itemModels.map((model) {
        final isFavorite = favoriteIds.contains(model.id);
        return model.toEntity(isFavorite);
      }).toList();
    } catch (e) {
      throw Exception('Failed to get items: $e');
    }
  }

  @override
  Future<void> toggleFavorite(String itemId) async {
    try {
      final List<String> favoriteIds = await localDataSource.getFavoriteIds();

      if (favoriteIds.contains(itemId)) {
        favoriteIds.remove(itemId);
      } else {
        favoriteIds.add(itemId);
      }

      await localDataSource.saveFavoriteIds(favoriteIds);
    } catch (e) {
      throw Exception('Failed to toggle favorite: $e');
    }
  }

  @override
  Future<List<String>> getFavoriteIds() async {
    return await localDataSource.getFavoriteIds();
  }

  @override
  Future<void> saveFavoriteIds(List<String> favoriteIds) async {
    await localDataSource.saveFavoriteIds(favoriteIds);
  }
}
