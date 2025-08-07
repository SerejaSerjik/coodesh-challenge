import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String id;
  final String title;
  final bool isFavorite;
  final DateTime timestamp;
  final String tag;
  final String tagColor;

  const Item({
    required this.id,
    required this.title,
    required this.isFavorite,
    required this.timestamp,
    required this.tag,
    required this.tagColor,
  });

  Item copyWith({String? id, String? title, bool? isFavorite, DateTime? timestamp, String? tag, String? tagColor}) {
    return Item(
      id: id ?? this.id,
      title: title ?? this.title,
      isFavorite: isFavorite ?? this.isFavorite,
      timestamp: timestamp ?? this.timestamp,
      tag: tag ?? this.tag,
      tagColor: tagColor ?? this.tagColor,
    );
  }

  @override
  List<Object?> get props => [id, title, isFavorite, timestamp, tag, tagColor];
}
