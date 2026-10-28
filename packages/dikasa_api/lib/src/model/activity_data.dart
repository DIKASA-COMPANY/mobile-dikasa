//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/cash_activity_event.dart';
import 'package:dikasa_api/src/model/session_record.dart';
import 'package:dikasa_api/src/model/movement_capabilities.dart';
import 'package:dikasa_api/src/model/cash_flow_totals.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ActivityData {
  /// Returns a new [ActivityData] instance.
  ActivityData({
    required this.capabilities,

    required this.events,

    required this.session,

    required this.totals,
  });

  @JsonKey(name: r'capabilities', required: true, includeIfNull: false)
  final MovementCapabilities capabilities;

  @JsonKey(name: r'events', required: true, includeIfNull: true)
  final List<CashActivityEvent>? events;

  @JsonKey(name: r'session', required: true, includeIfNull: false)
  final SessionRecord session;

  @JsonKey(name: r'totals', required: true, includeIfNull: false)
  final CashFlowTotals totals;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityData &&
          other.capabilities == capabilities &&
          other.events == events &&
          other.session == session &&
          other.totals == totals;

  @override
  int get hashCode =>
      capabilities.hashCode +
      (events == null ? 0 : events.hashCode) +
      session.hashCode +
      totals.hashCode;

  factory ActivityData.fromJson(Map<String, dynamic> json) =>
      _$ActivityDataFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
