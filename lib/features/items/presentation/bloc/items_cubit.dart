import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_items_usecase.dart';
import '../../domain/usecases/toggle_favorite_usecase.dart';
import 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  final GetItemsUseCase getItemsUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  ItemsCubit({required this.getItemsUseCase, required this.toggleFavoriteUseCase}) : super(ItemsInitial());

  Future<void> loadItems() async {
    emit(ItemsLoading());

    try {
      final items = await getItemsUseCase();
      final favoriteCount = items.where((item) => item.isFavorite).length;

      emit(ItemsLoaded(items: items, filteredItems: items, searchQuery: '', favoriteCount: favoriteCount));
    } catch (e) {
      emit(ItemsError(e.toString()));
    }
  }

  void searchItems(String query) {
    if (state is ItemsLoaded) {
      final currentState = state as ItemsLoaded;
      final filteredItems = currentState.items
          .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();

      emit(currentState.copyWith(filteredItems: filteredItems, searchQuery: query));
    }
  }

  Future<void> toggleFavorite(String itemId) async {
    if (state is ItemsLoaded) {
      final currentState = state as ItemsLoaded;

      try {
        await toggleFavoriteUseCase(itemId);

        // Update the items list with new favorite status
        final updatedItems = currentState.items.map((item) {
          if (item.id == itemId) {
            return item.copyWith(isFavorite: !item.isFavorite);
          }
          return item;
        }).toList();

        // Update filtered items as well
        final updatedFilteredItems = currentState.filteredItems.map((item) {
          if (item.id == itemId) {
            return item.copyWith(isFavorite: !item.isFavorite);
          }
          return item;
        }).toList();

        final favoriteCount = updatedItems.where((item) => item.isFavorite).length;

        emit(
          currentState.copyWith(items: updatedItems, filteredItems: updatedFilteredItems, favoriteCount: favoriteCount),
        );
      } catch (e) {
        emit(ItemsError(e.toString()));
      }
    }
  }
}
