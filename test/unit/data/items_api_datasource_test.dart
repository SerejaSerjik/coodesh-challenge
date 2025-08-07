import 'package:flutter_test/flutter_test.dart';
import 'package:coodesh_challenge/features/items/data/datasources/items_api_datasource.dart';
import 'package:coodesh_challenge/features/items/data/models/item_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('ItemsApiDataSource', () {
    late ItemsApiDataSourceImpl dataSource;

    setUp(() {
      dataSource = const ItemsApiDataSourceImpl();
    });

    test('getItems returns list of ItemModel', () async {
      final items = await dataSource.getItems();

      expect(items, isA<List<ItemModel>>());
      expect(items.isNotEmpty, true);
      expect(items.length, 20); // We have 20 items in our mock data
    });

    test('getItems returns items with correct structure', () async {
      final items = await dataSource.getItems();
      final firstItem = items.first;

      expect(firstItem.id, isNotEmpty);
      expect(firstItem.title, isNotEmpty);
      expect(firstItem.createdAt, isNotEmpty);
      expect(firstItem.tag, isNotEmpty);
      expect(firstItem.tagColor, isNotEmpty);
    });

    test('items have valid tags', () async {
      final items = await dataSource.getItems();
      final tags = items.map((item) => item.tag).toSet();

      // Check that all tags are valid
      expect(tags.every((tag) => ['New', 'Old', 'Hot'].contains(tag)), true);
    });

    test('items have valid colors', () async {
      final items = await dataSource.getItems();
      final colors = items.map((item) => item.tagColor).toSet();

      // Check that all colors are valid
      expect(colors.every((color) => ['#4CAF50', '#FF5722', '#9E9E9E', '#2196F3'].contains(color)), true);
    });

    test('toEntity converts model to entity correctly', () async {
      final items = await dataSource.getItems();
      final firstItem = items.first;
      final entity = firstItem.toEntity(true);

      expect(entity.id, firstItem.id);
      expect(entity.title, firstItem.title);
      expect(entity.isFavorite, true);
      expect(entity.tag, firstItem.tag);
      expect(entity.tagColor, firstItem.tagColor);
    });
  });
}
