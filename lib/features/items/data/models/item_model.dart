import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/item.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel extends Equatable {
  final String id;
  final String title;
  @JsonKey(name: 'created_at')
  final String createdAt;
  final String tag;
  @JsonKey(name: 'tag_color')
  final String tagColor;

  const ItemModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.tag,
    required this.tagColor,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  Item toEntity(bool isFavorite) {
    return Item(
      id: id,
      title: title,
      isFavorite: isFavorite,
      timestamp: DateTime.parse(createdAt),
      tag: tag,
      tagColor: tagColor,
    );
  }

  @override
  List<Object?> get props => [id, title, createdAt, tag, tagColor];
}
