// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
  id: json['id'] as String,
  title: json['title'] as String,
  createdAt: json['created_at'] as String,
  tag: json['tag'] as String,
  tagColor: json['tag_color'] as String,
);

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'created_at': instance.createdAt,
  'tag': instance.tag,
  'tag_color': instance.tagColor,
};
