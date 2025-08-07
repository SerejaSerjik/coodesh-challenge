import 'package:flutter_test/flutter_test.dart';
import 'package:coodesh_challenge/features/items/domain/usecases/get_items_usecase.dart';
import 'package:coodesh_challenge/features/items/domain/repositories/items_repository.dart';
import 'package:coodesh_challenge/features/items/domain/entities/item.dart';

class MockItemsRepository implements ItemsRepository {
  @override
  Future<List<Item>> getItems() async {
    return [
      Item(
        id: '1',
        title: 'Test Item 1',
        isFavorite: false,
        timestamp: DateTime.now(),
        tag: 'New',
        tagColor: '#4CAF50',
      ),
      Item(id: '2', title: 'Test Item 2', isFavorite: true, timestamp: DateTime.now(), tag: 'Hot', tagColor: '#FF5722'),
    ];
  }

  @override
  Future<void> toggleFavorite(String itemId) async {
    // Mock implementation
  }

  @override
  Future<List<String>> getFavoriteIds() async {
    return ['2'];
  }

  @override
  Future<void> saveFavoriteIds(List<String> favoriteIds) async {
    // Mock implementation
  }
}

void main() {
  group('GetItemsUseCase', () {
    late GetItemsUseCase useCase;
    late MockItemsRepository mockRepository;

    setUp(() {
      mockRepository = MockItemsRepository();
      useCase = GetItemsUseCase(mockRepository);
    });

    test('should return list of items from repository', () async {
      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<List<Item>>());
      expect(result.length, 2);
      expect(result.first.title, 'Test Item 1');
      expect(result.last.title, 'Test Item 2');
    });

    test('should return items with correct properties', () async {
      // Act
      final result = await useCase();

      // Assert
      final firstItem = result.first;
      expect(firstItem.id, '1');
      expect(firstItem.title, 'Test Item 1');
      expect(firstItem.isFavorite, false);
      expect(firstItem.tag, 'New');
      expect(firstItem.tagColor, '#4CAF50');

      final secondItem = result.last;
      expect(secondItem.id, '2');
      expect(secondItem.title, 'Test Item 2');
      expect(secondItem.isFavorite, true);
      expect(secondItem.tag, 'Hot');
      expect(secondItem.tagColor, '#FF5722');
    });
  });
}
