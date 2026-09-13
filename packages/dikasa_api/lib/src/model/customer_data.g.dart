// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CustomerDataCWProxy {
  CustomerData address(String address);

  CustomerData createdAt(DateTime createdAt);

  CustomerData email(String? email);

  CustomerData gender(GenderData? gender);

  CustomerData id(String id);

  CustomerData name(String name);

  CustomerData phoneNumber(String phoneNumber);

  CustomerData points(int points);

  CustomerData updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CustomerData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CustomerData(...).copyWith(id: 12, name: "My name")
  /// ````
  CustomerData call({
    String address,
    DateTime createdAt,
    String? email,
    GenderData? gender,
    String id,
    String name,
    String phoneNumber,
    int points,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCustomerData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCustomerData.copyWith.fieldName(...)`
class _$CustomerDataCWProxyImpl implements _$CustomerDataCWProxy {
  const _$CustomerDataCWProxyImpl(this._value);

  final CustomerData _value;

  @override
  CustomerData address(String address) => this(address: address);

  @override
  CustomerData createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  CustomerData email(String? email) => this(email: email);

  @override
  CustomerData gender(GenderData? gender) => this(gender: gender);

  @override
  CustomerData id(String id) => this(id: id);

  @override
  CustomerData name(String name) => this(name: name);

  @override
  CustomerData phoneNumber(String phoneNumber) =>
      this(phoneNumber: phoneNumber);

  @override
  CustomerData points(int points) => this(points: points);

  @override
  CustomerData updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CustomerData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CustomerData(...).copyWith(id: 12, name: "My name")
  /// ````
  CustomerData call({
    Object? address = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? phoneNumber = const $CopyWithPlaceholder(),
    Object? points = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return CustomerData(
      address: address == const $CopyWithPlaceholder()
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      gender: gender == const $CopyWithPlaceholder()
          ? _value.gender
          // ignore: cast_nullable_to_non_nullable
          : gender as GenderData?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      phoneNumber: phoneNumber == const $CopyWithPlaceholder()
          ? _value.phoneNumber
          // ignore: cast_nullable_to_non_nullable
          : phoneNumber as String,
      points: points == const $CopyWithPlaceholder()
          ? _value.points
          // ignore: cast_nullable_to_non_nullable
          : points as int,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $CustomerDataCopyWith on CustomerData {
  /// Returns a callable class that can be used as follows: `instanceOfCustomerData.copyWith(...)` or like so:`instanceOfCustomerData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CustomerDataCWProxy get copyWith => _$CustomerDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerData _$CustomerDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CustomerData',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'address',
            'created_at',
            'id',
            'name',
            'phone_number',
            'points',
            'updated_at',
          ],
        );
        final val = CustomerData(
          address: $checkedConvert('address', (v) => v as String),
          createdAt: $checkedConvert(
            'created_at',
            (v) => DateTime.parse(v as String),
          ),
          email: $checkedConvert('email', (v) => v as String?),
          gender: $checkedConvert(
            'gender',
            (v) => v == null
                ? null
                : GenderData.fromJson(v as Map<String, dynamic>),
          ),
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          phoneNumber: $checkedConvert('phone_number', (v) => v as String),
          points: $checkedConvert('points', (v) => (v as num).toInt()),
          updatedAt: $checkedConvert(
            'updated_at',
            (v) => DateTime.parse(v as String),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'createdAt': 'created_at',
        'phoneNumber': 'phone_number',
        'updatedAt': 'updated_at',
      },
    );

Map<String, dynamic> _$CustomerDataToJson(CustomerData instance) =>
    <String, dynamic>{
      'address': instance.address,
      'created_at': instance.createdAt.toIso8601String(),
      'email': ?instance.email,
      'gender': ?instance.gender?.toJson(),
      'id': instance.id,
      'name': instance.name,
      'phone_number': instance.phoneNumber,
      'points': instance.points,
      'updated_at': instance.updatedAt.toIso8601String(),
    };
