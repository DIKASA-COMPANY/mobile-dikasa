// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderCWProxy {
  Order createdAt(DateTime createdAt);

  Order createdBy(String createdBy);

  Order creatorName(String creatorName);

  Order estimatedSubtotal(int estimatedSubtotal);

  Order id(String id);

  Order items(List<Item>? items);

  Order label(String label);

  Order orderTypeId(String orderTypeId);

  Order revision(int revision);

  Order status(String status);

  Order totalQuantity(int totalQuantity);

  Order transactionId(String? transactionId);

  Order updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Order(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Order(...).copyWith(id: 12, name: "My name")
  /// ````
  Order call({
    DateTime createdAt,
    String createdBy,
    String creatorName,
    int estimatedSubtotal,
    String id,
    List<Item>? items,
    String label,
    String orderTypeId,
    int revision,
    String status,
    int totalQuantity,
    String? transactionId,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrder.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrder.copyWith.fieldName(...)`
class _$OrderCWProxyImpl implements _$OrderCWProxy {
  const _$OrderCWProxyImpl(this._value);

  final Order _value;

  @override
  Order createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  Order createdBy(String createdBy) => this(createdBy: createdBy);

  @override
  Order creatorName(String creatorName) => this(creatorName: creatorName);

  @override
  Order estimatedSubtotal(int estimatedSubtotal) =>
      this(estimatedSubtotal: estimatedSubtotal);

  @override
  Order id(String id) => this(id: id);

  @override
  Order items(List<Item>? items) => this(items: items);

  @override
  Order label(String label) => this(label: label);

  @override
  Order orderTypeId(String orderTypeId) => this(orderTypeId: orderTypeId);

  @override
  Order revision(int revision) => this(revision: revision);

  @override
  Order status(String status) => this(status: status);

  @override
  Order totalQuantity(int totalQuantity) => this(totalQuantity: totalQuantity);

  @override
  Order transactionId(String? transactionId) =>
      this(transactionId: transactionId);

  @override
  Order updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Order(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Order(...).copyWith(id: 12, name: "My name")
  /// ````
  Order call({
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? createdBy = const $CopyWithPlaceholder(),
    Object? creatorName = const $CopyWithPlaceholder(),
    Object? estimatedSubtotal = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? orderTypeId = const $CopyWithPlaceholder(),
    Object? revision = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? totalQuantity = const $CopyWithPlaceholder(),
    Object? transactionId = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Order(
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      createdBy: createdBy == const $CopyWithPlaceholder()
          ? _value.createdBy
          // ignore: cast_nullable_to_non_nullable
          : createdBy as String,
      creatorName: creatorName == const $CopyWithPlaceholder()
          ? _value.creatorName
          // ignore: cast_nullable_to_non_nullable
          : creatorName as String,
      estimatedSubtotal: estimatedSubtotal == const $CopyWithPlaceholder()
          ? _value.estimatedSubtotal
          // ignore: cast_nullable_to_non_nullable
          : estimatedSubtotal as int,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
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
      revision: revision == const $CopyWithPlaceholder()
          ? _value.revision
          // ignore: cast_nullable_to_non_nullable
          : revision as int,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String,
      totalQuantity: totalQuantity == const $CopyWithPlaceholder()
          ? _value.totalQuantity
          // ignore: cast_nullable_to_non_nullable
          : totalQuantity as int,
      transactionId: transactionId == const $CopyWithPlaceholder()
          ? _value.transactionId
          // ignore: cast_nullable_to_non_nullable
          : transactionId as String?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $OrderCopyWith on Order {
  /// Returns a callable class that can be used as follows: `instanceOfOrder.copyWith(...)` or like so:`instanceOfOrder.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderCWProxy get copyWith => _$OrderCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Order',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'created_at',
        'created_by',
        'creator_name',
        'estimated_subtotal',
        'id',
        'items',
        'label',
        'order_type_id',
        'revision',
        'status',
        'total_quantity',
        'transaction_id',
        'updated_at',
      ],
    );
    final val = Order(
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      createdBy: $checkedConvert('created_by', (v) => v as String),
      creatorName: $checkedConvert('creator_name', (v) => v as String),
      estimatedSubtotal: $checkedConvert(
        'estimated_subtotal',
        (v) => (v as num).toInt(),
      ),
      id: $checkedConvert('id', (v) => v as String),
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>?)
            ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      label: $checkedConvert('label', (v) => v as String),
      orderTypeId: $checkedConvert('order_type_id', (v) => v as String),
      revision: $checkedConvert('revision', (v) => (v as num).toInt()),
      status: $checkedConvert('status', (v) => v as String),
      totalQuantity: $checkedConvert(
        'total_quantity',
        (v) => (v as num).toInt(),
      ),
      transactionId: $checkedConvert('transaction_id', (v) => v as String?),
      updatedAt: $checkedConvert(
        'updated_at',
        (v) => DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'createdAt': 'created_at',
    'createdBy': 'created_by',
    'creatorName': 'creator_name',
    'estimatedSubtotal': 'estimated_subtotal',
    'orderTypeId': 'order_type_id',
    'totalQuantity': 'total_quantity',
    'transactionId': 'transaction_id',
    'updatedAt': 'updated_at',
  },
);

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
  'created_at': instance.createdAt.toIso8601String(),
  'created_by': instance.createdBy,
  'creator_name': instance.creatorName,
  'estimated_subtotal': instance.estimatedSubtotal,
  'id': instance.id,
  'items': instance.items?.map((e) => e.toJson()).toList(),
  'label': instance.label,
  'order_type_id': instance.orderTypeId,
  'revision': instance.revision,
  'status': instance.status,
  'total_quantity': instance.totalQuantity,
  'transaction_id': instance.transactionId,
  'updated_at': instance.updatedAt.toIso8601String(),
};
