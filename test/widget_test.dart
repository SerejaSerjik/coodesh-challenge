// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coodesh_challenge/features/items/presentation/bloc/items_cubit.dart';
import 'package:coodesh_challenge/features/items/presentation/pages/items_page.dart';
import 'package:coodesh_challenge/features/items/domain/usecases/get_items_usecase.dart';
import 'package:coodesh_challenge/features/items/domain/usecases/toggle_favorite_usecase.dart';
import 'package:coodesh_challenge/features/items/domain/repositories/items_repository.dart';
import 'package:coodesh_challenge/features/items/domain/entities/item.dart';

// Mock repository for testing
class MockItemsRepository implements ItemsRepository {
  @override
  Future<List<Item>> getItems() async {
    // Return empty list for testing
    return [];
  }

  @override
  Future<void> toggleFavorite(String itemId) async {
    // Mock implementation
  }

  @override
  Future<List<String>> getFavoriteIds() async {
    return [];
  }

  @override
  Future<void> saveFavoriteIds(List<String> favoriteIds) async {
    // Mock implementation
  }
}

void main() {
  group('App Widget Tests', () {
    testWidgets('App smoke test - initial state', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MaterialApp(home: ItemsPage()));

      // Verify that the app title is displayed
      expect(find.text('Items List'), findsOneWidget);

      // Verify that the search bar is present
      expect(find.byType(TextField), findsOneWidget);

      // Verify that the search hint text is displayed
      expect(find.text('Search items by title...'), findsOneWidget);
    });

    testWidgets('App loads with proper BLoC setup', (WidgetTester tester) async {
      final mockRepository = MockItemsRepository();
      final getItemsUseCase = GetItemsUseCase(mockRepository);
      final toggleFavoriteUseCase = ToggleFavoriteUseCase(mockRepository);
      final cubit = ItemsCubit(getItemsUseCase: getItemsUseCase, toggleFavoriteUseCase: toggleFavoriteUseCase);

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ItemsCubit>(create: (context) => cubit, child: const ItemsPage()),
        ),
      );

      // Verify initial state
      expect(find.text('Items List'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
