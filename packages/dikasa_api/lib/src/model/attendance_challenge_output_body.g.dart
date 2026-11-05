// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_challenge_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceChallengeOutputBodyCWProxy {
  AttendanceChallengeOutputBody data(Challenge data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceChallengeOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceChallengeOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceChallengeOutputBody call({Challenge data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceChallengeOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceChallengeOutputBody.copyWith.fieldName(...)`
class _$AttendanceChallengeOutputBodyCWProxyImpl
    implements _$AttendanceChallengeOutputBodyCWProxy {
  const _$AttendanceChallengeOutputBodyCWProxyImpl(this._value);

  final AttendanceChallengeOutputBody _value;

  @override
  AttendanceChallengeOutputBody data(Challenge data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceChallengeOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceChallengeOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceChallengeOutputBody call({
    Object? data = const $CopyWithPlaceholder(),
  }) {
    return AttendanceChallengeOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Challenge,
    );
  }
}

extension $AttendanceChallengeOutputBodyCopyWith
    on AttendanceChallengeOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfAttendanceChallengeOutputBody.copyWith(...)` or like so:`instanceOfAttendanceChallengeOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceChallengeOutputBodyCWProxy get copyWith =>
      _$AttendanceChallengeOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceChallengeOutputBody _$AttendanceChallengeOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AttendanceChallengeOutputBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['data']);
  final val = AttendanceChallengeOutputBody(
    data: $checkedConvert(
      'data',
      (v) => Challenge.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$AttendanceChallengeOutputBodyToJson(
  AttendanceChallengeOutputBody instance,
) => <String, dynamic>{'data': instance.data.toJson()};
