// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SelectedItemCWProxy {
  SelectedItem quantity(int quantity);

  SelectedItem restockQuantity(int restockQuantity);

  SelectedItem transactionItemId(String transactionItemId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SelectedItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SelectedItem(...).copyWith(id: 12, name: "My name")
  /// ````
  SelectedItem call({
    int quantity,
    int restockQuantity,
    String transactionItemId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSelectedItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSelectedItem.copyWith.fieldName(...)`
class _$SelectedItemCWProxyImpl implements _$SelectedItemCWProxy {
  const _$SelectedItemCWProxyImpl(this._value);

  final SelectedItem _value;

  @override
  SelectedItem quantity(int quantity) => this(quantity: quantity);

  @override
  SelectedItem restockQuantity(int restockQuantity) =>
      this(restockQuantity: restockQuantity);

  @override
  SelectedItem transactionItemId(String transactionItemId) =>
      this(transactionItemId: transactionItemId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SelectedItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SelectedItem(...).copyWith(id: 12, name: "My name")
  /// ````
  SelectedItem call({
    Object? quantity = const $CopyWithPlaceholder(),
    Object? restockQuantity = const $CopyWithPlaceholder(),
    Object? transactionItemId = const $CopyWithPlaceholder(),
  }) {
    return SelectedItem(
      quantity: quantity == const $CopyWithPlaceholder()
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as int,
      restockQuantity: restockQuantity == const $CopyWithPlaceholder()
          ? _value.restockQuantity
          // ignore: cast_nullable_to_non_nullable
          : restockQuantity as int,
      transactionItemId: transactionItemId == const $CopyWithPlaceholder()
          ? _value.transactionItemId
          // ignore: cast_nullable_to_non_nullable
          : transactionItemId as String,
    );
  }
}

extension $SelectedItemCopyWith on SelectedItem {
  /// Returns a callable class that can be used as follows: `instanceOfSelectedItem.copyWith(...)` or like so:`instanceOfSelectedItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SelectedItemCWProxy get copyWith => _$SelectedItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectedItem _$SelectedItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SelectedItem',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'quantity',
            'restock_quantity',
            'transaction_item_id',
          ],
        );
        final val = SelectedItem(
          quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
          restockQuantity: $checkedConvert(
            'restock_quantity',
            (v) => (v as num).toInt(),
          ),
          transactionItemId: $checkedConvert(
            'transaction_item_id',
            (v) => v as String,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'restockQuantity': 'restock_quantity',
        'transactionItemId': 'transaction_item_id',
      },
    );

Map<String, dynamic> _$SelectedItemToJson(SelectedItem instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'restock_quantity': instance.restockQuantity,
      'transaction_item_id': instance.transactionItemId,
    };
