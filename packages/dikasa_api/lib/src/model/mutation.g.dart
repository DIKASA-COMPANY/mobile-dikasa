// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mutation.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MutationCWProxy {
  Mutation expectedRevision(int? expectedRevision);

  Mutation items(List<Item>? items);

  Mutation label(String label);

  Mutation orderTypeId(String orderTypeId);

  Mutation requestId(String requestId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Mutation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Mutation(...).copyWith(id: 12, name: "My name")
  /// ````
  Mutation call({
    int? expectedRevision,
    List<Item>? items,
    String label,
    String orderTypeId,
    String requestId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMutation.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMutation.copyWith.fieldName(...)`
class _$MutationCWProxyImpl implements _$MutationCWProxy {
  const _$MutationCWProxyImpl(this._value);

  final Mutation _value;

  @override
  Mutation expectedRevision(int? expectedRevision) =>
      this(expectedRevision: expectedRevision);

  @override
  Mutation items(List<Item>? items) => this(items: items);

  @override
  Mutation label(String label) => this(label: label);

  @override
  Mutation orderTypeId(String orderTypeId) => this(orderTypeId: orderTypeId);

  @override
  Mutation requestId(String requestId) => this(requestId: requestId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Mutation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Mutation(...).copyWith(id: 12, name: "My name")
  /// ````
  Mutation call({
    Object? expectedRevision = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? orderTypeId = const $CopyWithPlaceholder(),
    Object? requestId = const $CopyWithPlaceholder(),
  }) {
    return Mutation(
      expectedRevision: expectedRevision == const $CopyWithPlaceholder()
          ? _value.expectedRevision
          // ignore: cast_nullable_to_non_nullable
          : expectedRevision as int?,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<Item>?,
      label: label == const $CopyWithPlaceholder()
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String,
      orderTypeId: orderTypeId == const $CopyWithPlaceholder()
          ? _value.orderTypeId
          // ignore: cast_nullable_to_non_nullable
          : orderTypeId as String,
      requestId: requestId == const $CopyWithPlaceholder()
          ? _value.requestId
          // ignore: cast_nullable_to_non_nullable
          : requestId as String,
    );
  }
}

extension $MutationCopyWith on Mutation {
  /// Returns a callable class that can be used as follows: `instanceOfMutation.copyWith(...)` or like so:`instanceOfMutation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MutationCWProxy get copyWith => _$MutationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mutation _$MutationFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Mutation',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['items', 'label', 'order_type_id', 'request_id'],
    );
    final val = Mutation(
      expectedRevision: $checkedConvert(
        'expected_revision',
        (v) => (v as num?)?.toInt(),
      ),
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>?)
            ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      label: $checkedConvert('label', (v) => v as String),
      orderTypeId: $checkedConvert('order_type_id', (v) => v as String),
      requestId: $checkedConvert('request_id', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'expectedRevision': 'expected_revision',
    'orderTypeId': 'order_type_id',
    'requestId': 'request_id',
  },
);

Map<String, dynamic> _$MutationToJson(Mutation instance) => <String, dynamic>{
  'expected_revision': ?instance.expectedRevision,
  'items': instance.items?.map((e) => e.toJson()).toList(),
  'label': instance.label,
  'order_type_id': instance.orderTypeId,
  'request_id': instance.requestId,
};
