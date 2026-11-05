// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChallengeCWProxy {
  Challenge expiresAt(DateTime expiresAt);

  Challenge id(String id);

  Challenge payload(String payload);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Challenge(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Challenge(...).copyWith(id: 12, name: "My name")
  /// ````
  Challenge call({DateTime expiresAt, String id, String payload});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfChallenge.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfChallenge.copyWith.fieldName(...)`
class _$ChallengeCWProxyImpl implements _$ChallengeCWProxy {
  const _$ChallengeCWProxyImpl(this._value);

  final Challenge _value;

  @override
  Challenge expiresAt(DateTime expiresAt) => this(expiresAt: expiresAt);

  @override
  Challenge id(String id) => this(id: id);

  @override
  Challenge payload(String payload) => this(payload: payload);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Challenge(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Challenge(...).copyWith(id: 12, name: "My name")
  /// ````
  Challenge call({
    Object? expiresAt = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return Challenge(
      expiresAt: expiresAt == const $CopyWithPlaceholder()
          ? _value.expiresAt
          // ignore: cast_nullable_to_non_nullable
          : expiresAt as DateTime,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      payload: payload == const $CopyWithPlaceholder()
          ? _value.payload
          // ignore: cast_nullable_to_non_nullable
          : payload as String,
    );
  }
}

extension $ChallengeCopyWith on Challenge {
  /// Returns a callable class that can be used as follows: `instanceOfChallenge.copyWith(...)` or like so:`instanceOfChallenge.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ChallengeCWProxy get copyWith => _$ChallengeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Challenge _$ChallengeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Challenge', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['expires_at', 'id', 'payload']);
      final val = Challenge(
        expiresAt: $checkedConvert(
          'expires_at',
          (v) => DateTime.parse(v as String),
        ),
        id: $checkedConvert('id', (v) => v as String),
        payload: $checkedConvert('payload', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'expiresAt': 'expires_at'});

Map<String, dynamic> _$ChallengeToJson(Challenge instance) => <String, dynamic>{
  'expires_at': instance.expiresAt.toIso8601String(),
  'id': instance.id,
  'payload': instance.payload,
};
