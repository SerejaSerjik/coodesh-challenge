import '../entities/item.dart';
import '../repositories/items_repository.dart';

class GetItemsUseCase {
  final ItemsRepository repository;

  const GetItemsUseCase(this.repository);

  Future<List<Item>> call() async {
    return await repository.getItems();
  }
}
