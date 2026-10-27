import 'package:dikasa_api/src/model/body.dart';
import 'package:dikasa_api/src/model/categories_output_body.dart';
import 'package:dikasa_api/src/model/category_data.dart';
import 'package:dikasa_api/src/model/category_output_body.dart';
import 'package:dikasa_api/src/model/category_request.dart';
import 'package:dikasa_api/src/model/change_pin_request.dart';
import 'package:dikasa_api/src/model/change_password_request.dart';
import 'package:dikasa_api/src/model/confirm_otp_request.dart';
import 'package:dikasa_api/src/model/confirm_otp_response.dart';
import 'package:dikasa_api/src/model/confirm_otp_response_data.dart';
import 'package:dikasa_api/src/model/customer_data.dart';
import 'package:dikasa_api/src/model/customers_output_body.dart';
import 'package:dikasa_api/src/model/gender_data.dart';
import 'package:dikasa_api/src/model/health_output_body.dart';
import 'package:dikasa_api/src/model/login_request.dart';
import 'package:dikasa_api/src/model/login_response.dart';
import 'package:dikasa_api/src/model/login_response_data.dart';
import 'package:dikasa_api/src/model/meta_struct.dart';
import 'package:dikasa_api/src/model/otp_response.dart';
import 'package:dikasa_api/src/model/otp_response_data.dart';
import 'package:dikasa_api/src/model/open_request.dart';
import 'package:dikasa_api/src/model/order_data.dart';
import 'package:dikasa_api/src/model/order_list_type_data.dart';
import 'package:dikasa_api/src/model/order_type_data.dart';
import 'package:dikasa_api/src/model/order_type_output_body.dart';
import 'package:dikasa_api/src/model/order_type_request.dart';
import 'package:dikasa_api/src/model/order_types_output_body.dart';
import 'package:dikasa_api/src/model/orders_output_body.dart';
import 'package:dikasa_api/src/model/pagination_meta.dart';
import 'package:dikasa_api/src/model/product_data.dart';
import 'package:dikasa_api/src/model/product_output_body.dart';
import 'package:dikasa_api/src/model/product_type_data.dart';
import 'package:dikasa_api/src/model/product_types_output_body.dart';
import 'package:dikasa_api/src/model/product_variant_data.dart';
import 'package:dikasa_api/src/model/product_variant_request.dart';
import 'package:dikasa_api/src/model/products_output_body.dart';
import 'package:dikasa_api/src/model/profile.dart';
import 'package:dikasa_api/src/model/profile_response.dart';
import 'package:dikasa_api/src/model/register_request.dart';
import 'package:dikasa_api/src/model/resend_otp_request.dart';
import 'package:dikasa_api/src/model/reservation_data.dart';
import 'package:dikasa_api/src/model/reservation_output_body.dart';
import 'package:dikasa_api/src/model/reservation_patch_request.dart';
import 'package:dikasa_api/src/model/reservation_request.dart';
import 'package:dikasa_api/src/model/reservations_output_body.dart';
import 'package:dikasa_api/src/model/restaurant_table_data.dart';
import 'package:dikasa_api/src/model/session_data.dart';
import 'package:dikasa_api/src/model/session_response.dart';
import 'package:dikasa_api/src/model/status_error.dart';
import 'package:dikasa_api/src/model/table_data.dart';
import 'package:dikasa_api/src/model/table_output_body.dart';
import 'package:dikasa_api/src/model/table_request.dart';
import 'package:dikasa_api/src/model/tables_output_body.dart';
import 'package:dikasa_api/src/model/tax_percentage_response.dart';
import 'package:dikasa_api/src/model/transaction_data.dart';
import 'package:dikasa_api/src/model/transaction_item_data.dart';
import 'package:dikasa_api/src/model/transaction_item_request.dart';
import 'package:dikasa_api/src/model/transaction_request.dart';
import 'package:dikasa_api/src/model/transaction_response.dart';
import 'package:dikasa_api/src/model/type_data.dart';
import 'package:dikasa_api/src/model/types_output_body.dart';
import 'package:dikasa_api/src/model/wallet_data.dart';
import 'package:dikasa_api/src/model/wallet_list_response.dart';
import 'package:dikasa_api/src/model/wallet_request.dart';
import 'package:dikasa_api/src/model/wallet_response.dart';

final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

ReturnType deserialize<ReturnType, BaseType>(
  dynamic value,
  String targetType, {
  bool growable = true,
}) {
  switch (targetType) {
    case 'String':
      return '$value' as ReturnType;
    case 'int':
      return (value is int ? value : int.parse('$value')) as ReturnType;
    case 'bool':
      if (value is bool) {
        return value as ReturnType;
      }
      final valueString = '$value'.toLowerCase();
      return (valueString == 'true' || valueString == '1') as ReturnType;
    case 'double':
      return (value is double ? value : double.parse('$value')) as ReturnType;
    case 'Body':
      return Body.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'CategoriesOutputBody':
      return CategoriesOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'CategoryData':
      return CategoryData.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'CategoryOutputBody':
      return CategoryOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'CategoryRequest':
      return CategoryRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ChangePINRequest':
      return ChangePINRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ChangePasswordRequest':
      return ChangePasswordRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ConfirmOTPRequest':
      return ConfirmOTPRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ConfirmOTPResponse':
      return ConfirmOTPResponse.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ConfirmOTPResponseData':
      return ConfirmOTPResponseData.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'CustomerData':
      return CustomerData.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'CustomersOutputBody':
      return CustomersOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'GenderData':
      return GenderData.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'HealthOutputBody':
      return HealthOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'LoginRequest':
      return LoginRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'LoginResponse':
      return LoginResponse.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'LoginResponseData':
      return LoginResponseData.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'MetaStruct':
      return MetaStruct.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OTPResponse':
      return OTPResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OTPResponseData':
      return OTPResponseData.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'OpenRequest':
      return OpenRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderData':
      return OrderData.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderListTypeData':
      return OrderListTypeData.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'OrderTypeData':
      return OrderTypeData.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'OrderTypeOutputBody':
      return OrderTypeOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'OrderTypeRequest':
      return OrderTypeRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'OrderTypesOutputBody':
      return OrderTypesOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'OrdersOutputBody':
      return OrdersOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'PaginationMeta':
      return PaginationMeta.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ProductData':
      return ProductData.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ProductOutputBody':
      return ProductOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ProductTypeData':
      return ProductTypeData.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ProductTypesOutputBody':
      return ProductTypesOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ProductVariantData':
      return ProductVariantData.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ProductVariantRequest':
      return ProductVariantRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ProductsOutputBody':
      return ProductsOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Profile':
      return Profile.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ProfileResponse':
      return ProfileResponse.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'RegisterRequest':
      return RegisterRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ResendOTPRequest':
      return ResendOTPRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ReservationData':
      return ReservationData.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ReservationOutputBody':
      return ReservationOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ReservationPatchRequest':
      return ReservationPatchRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ReservationRequest':
      return ReservationRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ReservationsOutputBody':
      return ReservationsOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'RestaurantTableData':
      return RestaurantTableData.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'SessionData':
      return SessionData.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'SessionResponse':
      return SessionResponse.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'StatusError':
      return StatusError.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'TableData':
      return TableData.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'TableOutputBody':
      return TableOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'TableRequest':
      return TableRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'TablesOutputBody':
      return TablesOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'TaxPercentageResponse':
      return TaxPercentageResponse.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'TransactionData':
      return TransactionData.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'TransactionItemData':
      return TransactionItemData.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'TransactionItemRequest':
      return TransactionItemRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'TransactionRequest':
      return TransactionRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'TransactionResponse':
      return TransactionResponse.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'TypeData':
      return TypeData.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'TypesOutputBody':
      return TypesOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'WalletData':
      return WalletData.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'WalletListResponse':
      return WalletListResponse.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'WalletRequest':
      return WalletRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'WalletResponse':
      return WalletResponse.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    default:
      RegExpMatch? match;

      if (value is List && (match = _regList.firstMatch(targetType)) != null) {
        targetType = match![1]!; // ignore: parameter_assignments
        return value
                .map<BaseType>(
                  (dynamic v) => deserialize<BaseType, BaseType>(
                    v,
                    targetType,
                    growable: growable,
                  ),
                )
                .toList(growable: growable)
            as ReturnType;
      }
      if (value is Set && (match = _regSet.firstMatch(targetType)) != null) {
        targetType = match![1]!; // ignore: parameter_assignments
        return value
                .map<BaseType>(
                  (dynamic v) => deserialize<BaseType, BaseType>(
                    v,
                    targetType,
                    growable: growable,
                  ),
                )
                .toSet()
            as ReturnType;
      }
      if (value is Map && (match = _regMap.firstMatch(targetType)) != null) {
        targetType = match![1]!.trim(); // ignore: parameter_assignments
        return Map<String, BaseType>.fromIterables(
              value.keys as Iterable<String>,
              value.values.map(
                (dynamic v) => deserialize<BaseType, BaseType>(
                  v,
                  targetType,
                  growable: growable,
                ),
              ),
            )
            as ReturnType;
      }
      break;
  }
  throw Exception('Cannot deserialize');
}
