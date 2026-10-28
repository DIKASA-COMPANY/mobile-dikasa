//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_pin_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ChangePINRequest {
  /// Returns a new [ChangePINRequest] instance.
  ChangePINRequest({
    this.currentPin,

    required this.newPin,

    required this.newPinConfirmation,
  });

  @JsonKey(name: r'current_pin', required: false, includeIfNull: false)
  final String? currentPin;

  @JsonKey(name: r'new_pin', required: true, includeIfNull: false)
  final String newPin;

  @JsonKey(name: r'new_pin_confirmation', required: true, includeIfNull: false)
  final String newPinConfirmation;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangePINRequest &&
          other.currentPin == currentPin &&
          other.newPin == newPin &&
          other.newPinConfirmation == newPinConfirmation;

  @override
  int get hashCode =>
      currentPin.hashCode + newPin.hashCode + newPinConfirmation.hashCode;

  factory ChangePINRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePINRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePINRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
