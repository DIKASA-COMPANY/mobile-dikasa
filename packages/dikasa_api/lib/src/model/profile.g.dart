// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProfileCWProxy {
  Profile avatarUrl(String? avatarUrl);

  Profile email(String? email);

  Profile firstName(String firstName);

  Profile genderId(String? genderId);

  Profile id(String id);

  Profile isActive(bool isActive);

  Profile lastName(String lastName);

  Profile outletId(String? outletId);

  Profile phoneNumber(String phoneNumber);

  Profile roleId(String roleId);

  Profile username(String username);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Profile(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Profile(...).copyWith(id: 12, name: "My name")
  /// ````
  Profile call({
    String? avatarUrl,
    String? email,
    String firstName,
    String? genderId,
    String id,
    bool isActive,
    String lastName,
    String? outletId,
    String phoneNumber,
    String roleId,
    String username,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProfile.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProfile.copyWith.fieldName(...)`
class _$ProfileCWProxyImpl implements _$ProfileCWProxy {
  const _$ProfileCWProxyImpl(this._value);

  final Profile _value;

  @override
  Profile avatarUrl(String? avatarUrl) => this(avatarUrl: avatarUrl);

  @override
  Profile email(String? email) => this(email: email);

  @override
  Profile firstName(String firstName) => this(firstName: firstName);

  @override
  Profile genderId(String? genderId) => this(genderId: genderId);

  @override
  Profile id(String id) => this(id: id);

  @override
  Profile isActive(bool isActive) => this(isActive: isActive);

  @override
  Profile lastName(String lastName) => this(lastName: lastName);

  @override
  Profile outletId(String? outletId) => this(outletId: outletId);

  @override
  Profile phoneNumber(String phoneNumber) => this(phoneNumber: phoneNumber);

  @override
  Profile roleId(String roleId) => this(roleId: roleId);

  @override
  Profile username(String username) => this(username: username);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Profile(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Profile(...).copyWith(id: 12, name: "My name")
  /// ````
  Profile call({
    Object? avatarUrl = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? firstName = const $CopyWithPlaceholder(),
    Object? genderId = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? lastName = const $CopyWithPlaceholder(),
    Object? outletId = const $CopyWithPlaceholder(),
    Object? phoneNumber = const $CopyWithPlaceholder(),
    Object? roleId = const $CopyWithPlaceholder(),
    Object? username = const $CopyWithPlaceholder(),
  }) {
    return Profile(
      avatarUrl: avatarUrl == const $CopyWithPlaceholder()
          ? _value.avatarUrl
          // ignore: cast_nullable_to_non_nullable
          : avatarUrl as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      firstName: firstName == const $CopyWithPlaceholder()
          ? _value.firstName
          // ignore: cast_nullable_to_non_nullable
          : firstName as String,
      genderId: genderId == const $CopyWithPlaceholder()
          ? _value.genderId
          // ignore: cast_nullable_to_non_nullable
          : genderId as String?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      lastName: lastName == const $CopyWithPlaceholder()
          ? _value.lastName
          // ignore: cast_nullable_to_non_nullable
          : lastName as String,
      outletId: outletId == const $CopyWithPlaceholder()
          ? _value.outletId
          // ignore: cast_nullable_to_non_nullable
          : outletId as String?,
      phoneNumber: phoneNumber == const $CopyWithPlaceholder()
          ? _value.phoneNumber
          // ignore: cast_nullable_to_non_nullable
          : phoneNumber as String,
      roleId: roleId == const $CopyWithPlaceholder()
          ? _value.roleId
          // ignore: cast_nullable_to_non_nullable
          : roleId as String,
      username: username == const $CopyWithPlaceholder()
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String,
    );
  }
}

extension $ProfileCopyWith on Profile {
  /// Returns a callable class that can be used as follows: `instanceOfProfile.copyWith(...)` or like so:`instanceOfProfile.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProfileCWProxy get copyWith => _$ProfileCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Profile',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'first_name',
        'id',
        'is_active',
        'last_name',
        'phone_number',
        'role_id',
        'username',
      ],
    );
    final val = Profile(
      avatarUrl: $checkedConvert('avatar_url', (v) => v as String?),
      email: $checkedConvert('email', (v) => v as String?),
      firstName: $checkedConvert('first_name', (v) => v as String),
      genderId: $checkedConvert('gender_id', (v) => v as String?),
      id: $checkedConvert('id', (v) => v as String),
      isActive: $checkedConvert('is_active', (v) => v as bool),
      lastName: $checkedConvert('last_name', (v) => v as String),
      outletId: $checkedConvert('outlet_id', (v) => v as String?),
      phoneNumber: $checkedConvert('phone_number', (v) => v as String),
      roleId: $checkedConvert('role_id', (v) => v as String),
      username: $checkedConvert('username', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'avatarUrl': 'avatar_url',
    'firstName': 'first_name',
    'genderId': 'gender_id',
    'isActive': 'is_active',
    'lastName': 'last_name',
    'outletId': 'outlet_id',
    'phoneNumber': 'phone_number',
    'roleId': 'role_id',
  },
);

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
  'avatar_url': ?instance.avatarUrl,
  'email': ?instance.email,
  'first_name': instance.firstName,
  'gender_id': ?instance.genderId,
  'id': instance.id,
  'is_active': instance.isActive,
  'last_name': instance.lastName,
  'outlet_id': ?instance.outletId,
  'phone_number': instance.phoneNumber,
  'role_id': instance.roleId,
  'username': instance.username,
};
