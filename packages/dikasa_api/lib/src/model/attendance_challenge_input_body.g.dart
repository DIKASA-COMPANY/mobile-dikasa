// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_challenge_input_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceChallengeInputBodyCWProxy {
  AttendanceChallengeInputBody action(
    AttendanceChallengeInputBodyActionEnum action,
  );

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceChallengeInputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceChallengeInputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceChallengeInputBody call({
    AttendanceChallengeInputBodyActionEnum action,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceChallengeInputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceChallengeInputBody.copyWith.fieldName(...)`
class _$AttendanceChallengeInputBodyCWProxyImpl
    implements _$AttendanceChallengeInputBodyCWProxy {
  const _$AttendanceChallengeInputBodyCWProxyImpl(this._value);

  final AttendanceChallengeInputBody _value;

  @override
  AttendanceChallengeInputBody action(
    AttendanceChallengeInputBodyActionEnum action,
  ) => this(action: action);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceChallengeInputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceChallengeInputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceChallengeInputBody call({
    Object? action = const $CopyWithPlaceholder(),
  }) {
    return AttendanceChallengeInputBody(
      action: action == const $CopyWithPlaceholder()
          ? _value.action
          // ignore: cast_nullable_to_non_nullable
          : action as AttendanceChallengeInputBodyActionEnum,
    );
  }
}

extension $AttendanceChallengeInputBodyCopyWith
    on AttendanceChallengeInputBody {
  /// Returns a callable class that can be used as follows: `instanceOfAttendanceChallengeInputBody.copyWith(...)` or like so:`instanceOfAttendanceChallengeInputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceChallengeInputBodyCWProxy get copyWith =>
      _$AttendanceChallengeInputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceChallengeInputBody _$AttendanceChallengeInputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AttendanceChallengeInputBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['action']);
  final val = AttendanceChallengeInputBody(
    action: $checkedConvert(
      'action',
      (v) => $enumDecode(
        _$AttendanceChallengeInputBodyActionEnumEnumMap,
        v,
        unknownValue:
            AttendanceChallengeInputBodyActionEnum.unknownDefaultOpenApi,
      ),
    ),
  );
  return val;
});

Map<String, dynamic> _$AttendanceChallengeInputBodyToJson(
  AttendanceChallengeInputBody instance,
) => <String, dynamic>{
  'action': _$AttendanceChallengeInputBodyActionEnumEnumMap[instance.action]!,
};

const _$AttendanceChallengeInputBodyActionEnumEnumMap = {
  AttendanceChallengeInputBodyActionEnum.in_: 'in',
  AttendanceChallengeInputBodyActionEnum.out_: 'out',
  AttendanceChallengeInputBodyActionEnum.unknownDefaultOpenApi:
      'unknown_default_open_api',
};
