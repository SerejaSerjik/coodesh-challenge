import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import '../models/item_model.dart';

abstract class ItemsApiDataSource {
  Future<List<ItemModel>> getItems();
}

class ItemsApiDataSourceImpl implements ItemsApiDataSource {
  const ItemsApiDataSourceImpl();

  @override
  Future<List<ItemModel>> getItems() async {
    try {
      log('Loading mock data from JSON file...');

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Load JSON data from assets
      final String jsonString = await rootBundle.loadString('assets/data/mock_items.json');
      final List<dynamic> jsonList = json.decode(jsonString);

      // Transform the API response to match our ItemModel structure
      return jsonList.map((json) {
        final tag = _getRandomTag();
        return ItemModel(
          id: json['id'].toString(),
          title: json['title'],
          createdAt: DateTime.now().subtract(Duration(hours: json['id'])).toIso8601String(),
          tag: tag,
          tagColor: _getColorForTag(tag),
        );
      }).toList();
    } catch (e) {
      log('Error in getItems: $e');
      throw Exception('Failed to load items: $e');
    }
  }

  String _getRandomTag() {
    final tags = ['New', 'Old', 'Hot'];
    return tags[DateTime.now().millisecond % tags.length];
  }

  String _getColorForTag(String tag) {
    switch (tag) {
      case 'New':
        return '#4CAF50'; // Green
      case 'Hot':
        return '#FF5722'; // Red/Orange
      case 'Old':
        return '#9E9E9E'; // Gray
      default:
        return '#2196F3'; // Blue fallback
    }
  }
}
