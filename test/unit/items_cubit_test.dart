import 'package:flutter_test/flutter_test.dart';
import 'package:coodesh_challenge/features/items/presentation/bloc/items_cubit.dart';
import 'package:coodesh_challenge/features/items/presentation/bloc/items_state.dart';
import 'package:coodesh_challenge/features/items/domain/entities/item.dart';
import 'package:coodesh_challenge/features/items/domain/usecases/get_items_usecase.dart';
import 'package:coodesh_challenge/features/items/domain/usecases/toggle_favorite_usecase.dart';
import 'package:coodesh_challenge/features/items/domain/repositories/items_repository.dart';

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
  group('ItemsCubit', () {
    late ItemsCubit cubit;
    late MockItemsRepository mockRepository;
    late GetItemsUseCase getItemsUseCase;
    late ToggleFavoriteUseCase toggleFavoriteUseCase;

    setUp(() {
      mockRepository = MockItemsRepository();
      getItemsUseCase = GetItemsUseCase(mockRepository);
      toggleFavoriteUseCase = ToggleFavoriteUseCase(mockRepository);
      cubit = ItemsCubit(getItemsUseCase: getItemsUseCase, toggleFavoriteUseCase: toggleFavoriteUseCase);
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is ItemsInitial', () {
      expect(cubit.state, isA<ItemsInitial>());
    });

    test('loadItems emits correct states', () async {
      // Listen to state changes
      final states = <ItemsState>[];
      cubit.stream.listen(states.add);

      // Trigger loadItems and wait for completion
      await cubit.loadItems();

      // Add a small delay to ensure all states are emitted
      await Future.delayed(const Duration(milliseconds: 10));

      // Verify states (Loading -> Loaded)
      expect(states.length, 2);
      expect(states[0], isA<ItemsLoading>());
      expect(states[1], isA<ItemsLoaded>());

      final loadedState = states[1] as ItemsLoaded;
      expect(loadedState.items.length, 2);
      expect(loadedState.favoriteCount, 1);
      expect(loadedState.searchQuery, isEmpty);
    });

    test('searchItems filters items correctly', () async {
      // First load items
      await cubit.loadItems();

      // Then search for a specific title
      cubit.searchItems('Item 1');

      final currentState = cubit.state as ItemsLoaded;
      expect(currentState.filteredItems.length, 1);
      expect(currentState.filteredItems.first.title, 'Test Item 1');
      expect(currentState.searchQuery, 'Item 1');
    });

    test('searchItems with empty query shows all items', () async {
      // First load items
      await cubit.loadItems();

      // Then search with empty query
      cubit.searchItems('');

      final currentState = cubit.state as ItemsLoaded;
      expect(currentState.filteredItems.length, 2);
      expect(currentState.searchQuery, isEmpty);
    });
  });
}
