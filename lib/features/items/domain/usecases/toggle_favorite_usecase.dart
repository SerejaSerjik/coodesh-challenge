import '../repositories/items_repository.dart';

class ToggleFavoriteUseCase {
  final ItemsRepository repository;

  const ToggleFavoriteUseCase(this.repository);

  Future<void> call(String itemId) async {
    await repository.toggleFavorite(itemId);
  }
}
