// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransactionResponseCWProxy {
  TransactionResponse data(TransactionData data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransactionResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  TransactionResponse call({TransactionData data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTransactionResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTransactionResponse.copyWith.fieldName(...)`
class _$TransactionResponseCWProxyImpl implements _$TransactionResponseCWProxy {
  const _$TransactionResponseCWProxyImpl(this._value);

  final TransactionResponse _value;

  @override
  TransactionResponse data(TransactionData data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransactionResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  TransactionResponse call({Object? data = const $CopyWithPlaceholder()}) {
    return TransactionResponse(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as TransactionData,
    );
  }
}

extension $TransactionResponseCopyWith on TransactionResponse {
  /// Returns a callable class that can be used as follows: `instanceOfTransactionResponse.copyWith(...)` or like so:`instanceOfTransactionResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TransactionResponseCWProxy get copyWith =>
      _$TransactionResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionResponse _$TransactionResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TransactionResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = TransactionResponse(
        data: $checkedConvert(
          'data',
          (v) => TransactionData.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TransactionResponseToJson(
  TransactionResponse instance,
) => <String, dynamic>{'data': instance.data.toJson()};
