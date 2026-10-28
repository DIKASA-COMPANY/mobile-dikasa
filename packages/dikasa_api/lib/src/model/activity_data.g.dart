// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ActivityDataCWProxy {
  ActivityData capabilities(MovementCapabilities capabilities);

  ActivityData events(List<CashActivityEvent>? events);

  ActivityData session(SessionRecord session);

  ActivityData totals(CashFlowTotals totals);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ActivityData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ActivityData(...).copyWith(id: 12, name: "My name")
  /// ````
  ActivityData call({
    MovementCapabilities capabilities,
    List<CashActivityEvent>? events,
    SessionRecord session,
    CashFlowTotals totals,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfActivityData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfActivityData.copyWith.fieldName(...)`
class _$ActivityDataCWProxyImpl implements _$ActivityDataCWProxy {
  const _$ActivityDataCWProxyImpl(this._value);

  final ActivityData _value;

  @override
  ActivityData capabilities(MovementCapabilities capabilities) =>
      this(capabilities: capabilities);

  @override
  ActivityData events(List<CashActivityEvent>? events) => this(events: events);

  @override
  ActivityData session(SessionRecord session) => this(session: session);

  @override
  ActivityData totals(CashFlowTotals totals) => this(totals: totals);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ActivityData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ActivityData(...).copyWith(id: 12, name: "My name")
  /// ````
  ActivityData call({
    Object? capabilities = const $CopyWithPlaceholder(),
    Object? events = const $CopyWithPlaceholder(),
    Object? session = const $CopyWithPlaceholder(),
    Object? totals = const $CopyWithPlaceholder(),
  }) {
    return ActivityData(
      capabilities: capabilities == const $CopyWithPlaceholder()
          ? _value.capabilities
          // ignore: cast_nullable_to_non_nullable
          : capabilities as MovementCapabilities,
      events: events == const $CopyWithPlaceholder()
          ? _value.events
          // ignore: cast_nullable_to_non_nullable
          : events as List<CashActivityEvent>?,
      session: session == const $CopyWithPlaceholder()
          ? _value.session
          // ignore: cast_nullable_to_non_nullable
          : session as SessionRecord,
      totals: totals == const $CopyWithPlaceholder()
          ? _value.totals
          // ignore: cast_nullable_to_non_nullable
          : totals as CashFlowTotals,
    );
  }
}

extension $ActivityDataCopyWith on ActivityData {
  /// Returns a callable class that can be used as follows: `instanceOfActivityData.copyWith(...)` or like so:`instanceOfActivityData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ActivityDataCWProxy get copyWith => _$ActivityDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityData _$ActivityDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ActivityData', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['capabilities', 'events', 'session', 'totals'],
      );
      final val = ActivityData(
        capabilities: $checkedConvert(
          'capabilities',
          (v) => MovementCapabilities.fromJson(v as Map<String, dynamic>),
        ),
        events: $checkedConvert(
          'events',
          (v) => (v as List<dynamic>?)
              ?.map(
                (e) => CashActivityEvent.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
        session: $checkedConvert(
          'session',
          (v) => SessionRecord.fromJson(v as Map<String, dynamic>),
        ),
        totals: $checkedConvert(
          'totals',
          (v) => CashFlowTotals.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ActivityDataToJson(ActivityData instance) =>
    <String, dynamic>{
      'capabilities': instance.capabilities.toJson(),
      'events': instance.events?.map((e) => e.toJson()).toList(),
      'session': instance.session.toJson(),
      'totals': instance.totals.toJson(),
    };
