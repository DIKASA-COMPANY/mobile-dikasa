//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/restaurant_table_data.dart';
import 'package:dikasa_api/src/model/order_list_type_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderData {
  /// Returns a new [OrderData] instance.
  OrderData({
    this.customerId,

    required this.customerName,

    required this.id,

    required this.orderType,

    required this.orderedAt,

    required this.receiptNumber,

    this.restaurantTable,

    required this.status,

    required this.totalAmount,

    required this.totalQuantity,
  });

  @JsonKey(name: r'customer_id', required: false, includeIfNull: false)
  final String? customerId;

  @JsonKey(name: r'customer_name', required: true, includeIfNull: false)
  final String customerName;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'order_type', required: true, includeIfNull: false)
  final OrderListTypeData orderType;

  @JsonKey(name: r'ordered_at', required: true, includeIfNull: false)
  final DateTime orderedAt;

  @JsonKey(name: r'receipt_number', required: true, includeIfNull: false)
  final String receiptNumber;

  @JsonKey(name: r'restaurant_table', required: false, includeIfNull: false)
  final RestaurantTableData? restaurantTable;

  @JsonKey(
    name: r'status',
    required: true,
    includeIfNull: false,
    unknownEnumValue: OrderDataStatusEnum.unknownDefaultOpenApi,
  )
  final OrderDataStatusEnum status;

  // minimum: 0
  @JsonKey(name: r'total_amount', required: true, includeIfNull: false)
  final int totalAmount;

  // minimum: 1
  @JsonKey(name: r'total_quantity', required: true, includeIfNull: false)
  final int totalQuantity;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderData &&
          other.customerId == customerId &&
          other.customerName == customerName &&
          other.id == id &&
          other.orderType == orderType &&
          other.orderedAt == orderedAt &&
          other.receiptNumber == receiptNumber &&
          other.restaurantTable == restaurantTable &&
          other.status == status &&
          other.totalAmount == totalAmount &&
          other.totalQuantity == totalQuantity;

  @override
  int get hashCode =>
      customerId.hashCode +
      customerName.hashCode +
      id.hashCode +
      orderType.hashCode +
      orderedAt.hashCode +
      receiptNumber.hashCode +
      restaurantTable.hashCode +
      status.hashCode +
      totalAmount.hashCode +
      totalQuantity.hashCode;

  factory OrderData.fromJson(Map<String, dynamic> json) =>
      _$OrderDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum OrderDataStatusEnum {
  @JsonValue(r'paid')
  paid(r'paid'),
  @JsonValue(r'refunded')
  refunded(r'refunded'),
  @JsonValue(r'cancelled')
  cancelled(r'cancelled'),
  @JsonValue(r'unknown_default_open_api')
  unknownDefaultOpenApi(r'unknown_default_open_api');

  const OrderDataStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
