import 'package:equatable/equatable.dart';
import '../../domain/entities/item.dart';

abstract class ItemsState extends Equatable {
  const ItemsState();

  @override
  List<Object?> get props => [];
}

class ItemsInitial extends ItemsState {}

class ItemsLoading extends ItemsState {}

class ItemsLoaded extends ItemsState {
  final List<Item> items;
  final List<Item> filteredItems;
  final String searchQuery;
  final int favoriteCount;

  const ItemsLoaded({
    required this.items,
    required this.filteredItems,
    required this.searchQuery,
    required this.favoriteCount,
  });

  ItemsLoaded copyWith({List<Item>? items, List<Item>? filteredItems, String? searchQuery, int? favoriteCount}) {
    return ItemsLoaded(
      items: items ?? this.items,
      filteredItems: filteredItems ?? this.filteredItems,
      searchQuery: searchQuery ?? this.searchQuery,
      favoriteCount: favoriteCount ?? this.favoriteCount,
    );
  }

  @override
  List<Object?> get props => [items, filteredItems, searchQuery, favoriteCount];
}

class ItemsError extends ItemsState {
  final String message;

  const ItemsError(this.message);

  @override
  List<Object?> get props => [message];
}
