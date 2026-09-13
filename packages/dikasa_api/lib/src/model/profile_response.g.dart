// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProfileResponseCWProxy {
  ProfileResponse data(Profile data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProfileResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProfileResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ProfileResponse call({Profile data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProfileResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProfileResponse.copyWith.fieldName(...)`
class _$ProfileResponseCWProxyImpl implements _$ProfileResponseCWProxy {
  const _$ProfileResponseCWProxyImpl(this._value);

  final ProfileResponse _value;

  @override
  ProfileResponse data(Profile data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProfileResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProfileResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ProfileResponse call({Object? data = const $CopyWithPlaceholder()}) {
    return ProfileResponse(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Profile,
    );
  }
}

extension $ProfileResponseCopyWith on ProfileResponse {
  /// Returns a callable class that can be used as follows: `instanceOfProfileResponse.copyWith(...)` or like so:`instanceOfProfileResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProfileResponseCWProxy get copyWith => _$ProfileResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ProfileResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = ProfileResponse(
        data: $checkedConvert(
          'data',
          (v) => Profile.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{'data': instance.data.toJson()};
