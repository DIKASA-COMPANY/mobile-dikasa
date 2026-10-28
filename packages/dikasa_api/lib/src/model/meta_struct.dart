//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meta_struct.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MetaStruct {
  /// Returns a new [MetaStruct] instance.
  MetaStruct({required this.page, required this.pageSize, required this.total});

  @JsonKey(name: r'page', required: true, includeIfNull: false)
  final int page;

  @JsonKey(name: r'page_size', required: true, includeIfNull: false)
  final int pageSize;

  @JsonKey(name: r'total', required: true, includeIfNull: false)
  final int total;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetaStruct &&
          other.page == page &&
          other.pageSize == pageSize &&
          other.total == total;

  @override
  int get hashCode => page.hashCode + pageSize.hashCode + total.hashCode;

  factory MetaStruct.fromJson(Map<String, dynamic> json) =>
      _$MetaStructFromJson(json);

  Map<String, dynamic> toJson() => _$MetaStructToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
