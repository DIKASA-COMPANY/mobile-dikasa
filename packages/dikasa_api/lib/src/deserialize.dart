import 'package:dikasa_api/src/model/activity_data.dart';
import 'package:dikasa_api/src/model/activity_meta.dart';
import 'package:dikasa_api/src/model/activity_page.dart';
import 'package:dikasa_api/src/model/body.dart';
import 'package:dikasa_api/src/model/cash_activity_event.dart';
import 'package:dikasa_api/src/model/cash_close_output_body.dart';
import 'package:dikasa_api/src/model/cash_detail_output_body.dart';
import 'package:dikasa_api/src/model/cash_flow_totals.dart';
import 'package:dikasa_api/src/model/cash_preview_output_body.dart';
import 'package:dikasa_api/src/model/cash_sessions_output_body.dart';
import 'package:dikasa_api/src/model/categories_output_body.dart';
import 'package:dikasa_api/src/model/category_data.dart';
import 'package:dikasa_api/src/model/category_output_body.dart';
import 'package:dikasa_api/src/model/category_request.dart';
import 'package:dikasa_api/src/model/change_pin_request.dart';
import 'package:dikasa_api/src/model/change_password_request.dart';
import 'package:dikasa_api/src/model/close_command.dart';
import 'package:dikasa_api/src/model/close_preview.dart';
import 'package:dikasa_api/src/model/close_selection.dart';
import 'package:dikasa_api/src/model/closed_reconciliation.dart';
import 'package:dikasa_api/src/model/command.dart';
import 'package:dikasa_api/src/model/confirm_otp_request.dart';
import 'package:dikasa_api/src/model/confirm_otp_response.dart';
import 'package:dikasa_api/src/model/confirm_otp_response_data.dart';
import 'package:dikasa_api/src/model/customer_data.dart';
import 'package:dikasa_api/src/model/customers_output_body.dart';
import 'package:dikasa_api/src/model/daily_point.dart';
import 'package:dikasa_api/src/model/detail_output_body.dart';
import 'package:dikasa_api/src/model/gender_choice.dart';
import 'package:dikasa_api/src/model/gender_data.dart';
import 'package:dikasa_api/src/model/gender_output_body.dart';
import 'package:dikasa_api/src/model/group_row.dart';
import 'package:dikasa_api/src/model/health_output_body.dart';
import 'package:dikasa_api/src/model/history_output_body.dart';
import 'package:dikasa_api/src/model/item.dart';
import 'package:dikasa_api/src/model/list_output_body.dart';
import 'package:dikasa_api/src/model/login_request.dart';
import 'package:dikasa_api/src/model/login_response.dart';
import 'package:dikasa_api/src/model/login_response_data.dart';
import 'package:dikasa_api/src/model/meta.dart';
import 'package:dikasa_api/src/model/meta_struct.dart';
import 'package:dikasa_api/src/model/method_row.dart';
import 'package:dikasa_api/src/model/method_summary.dart';
import 'package:dikasa_api/src/model/movement_capabilities.dart';
import 'package:dikasa_api/src/model/movement_detail.dart';
import 'package:dikasa_api/src/model/movement_detail_output_body.dart';
import 'package:dikasa_api/src/model/movement_output_body.dart';
import 'package:dikasa_api/src/model/movement_proof_output_body.dart';
import 'package:dikasa_api/src/model/movement_record.dart';
import 'package:dikasa_api/src/model/mutation.dart';
import 'package:dikasa_api/src/model/otp_response.dart';
import 'package:dikasa_api/src/model/otp_response_data.dart';
import 'package:dikasa_api/src/model/open_request.dart';
import 'package:dikasa_api/src/model/order.dart';
import 'package:dikasa_api/src/model/order_data.dart';
import 'package:dikasa_api/src/model/order_list_type_data.dart';
import 'package:dikasa_api/src/model/order_type_data.dart';
import 'package:dikasa_api/src/model/order_type_output_body.dart';
import 'package:dikasa_api/src/model/order_type_request.dart';
import 'package:dikasa_api/src/model/order_types_output_body.dart';
import 'package:dikasa_api/src/model/orders_output_body.dart';
import 'package:dikasa_api/src/model/output_body.dart';
import 'package:dikasa_api/src/model/pagination_meta.dart';
import 'package:dikasa_api/src/model/preview.dart';
import 'package:dikasa_api/src/model/preview_output_body.dart';
import 'package:dikasa_api/src/model/product_data.dart';
import 'package:dikasa_api/src/model/product_output_body.dart';
import 'package:dikasa_api/src/model/product_type_data.dart';
import 'package:dikasa_api/src/model/product_types_output_body.dart';
import 'package:dikasa_api/src/model/product_variant_data.dart';
import 'package:dikasa_api/src/model/product_variant_request.dart';
import 'package:dikasa_api/src/model/products_output_body.dart';
import 'package:dikasa_api/src/model/profile.dart';
import 'package:dikasa_api/src/model/profile_response.dart';
import 'package:dikasa_api/src/model/proof_link.dart';
import 'package:dikasa_api/src/model/receipt_item.dart';
import 'package:dikasa_api/src/model/receipt_snapshot.dart';
import 'package:dikasa_api/src/model/reconciliation_summary.dart';
import 'package:dikasa_api/src/model/refund.dart';
import 'package:dikasa_api/src/model/refund_item.dart';
import 'package:dikasa_api/src/model/refund_output_body.dart';
import 'package:dikasa_api/src/model/register_request.dart';
import 'package:dikasa_api/src/model/report.dart';
import 'package:dikasa_api/src/model/resend_otp_request.dart';
import 'package:dikasa_api/src/model/reservation_data.dart';
import 'package:dikasa_api/src/model/reservation_output_body.dart';
import 'package:dikasa_api/src/model/reservation_patch_request.dart';
import 'package:dikasa_api/src/model/reservation_request.dart';
import 'package:dikasa_api/src/model/reservations_output_body.dart';
import 'package:dikasa_api/src/model/restaurant_table_data.dart';
import 'package:dikasa_api/src/model/result.dart';
import 'package:dikasa_api/src/model/reversal_command.dart';
import 'package:dikasa_api/src/model/selected_item.dart';
import 'package:dikasa_api/src/model/selection.dart';
import 'package:dikasa_api/src/model/session_data.dart';
import 'package:dikasa_api/src/model/session_record.dart';
import 'package:dikasa_api/src/model/session_response.dart';
import 'package:dikasa_api/src/model/status_error.dart';
import 'package:dikasa_api/src/model/stock_command.dart';
import 'package:dikasa_api/src/model/stock_history_output_body.dart';
import 'package:dikasa_api/src/model/stock_movement.dart';
import 'package:dikasa_api/src/model/stock_write_output_body.dart';
import 'package:dikasa_api/src/model/table_data.dart';
import 'package:dikasa_api/src/model/table_output_body.dart';
import 'package:dikasa_api/src/model/table_request.dart';
import 'package:dikasa_api/src/model/tables_output_body.dart';
import 'package:dikasa_api/src/model/tax_percentage_response.dart';
import 'package:dikasa_api/src/model/totals.dart';
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
    case 'ActivityData':
      return ActivityData.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ActivityMeta':
      return ActivityMeta.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ActivityPage':
      return ActivityPage.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Body':
      return Body.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'CashActivityEvent':
      return CashActivityEvent.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'CashCloseOutputBody':
      return CashCloseOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'CashDetailOutputBody':
      return CashDetailOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'CashFlowTotals':
      return CashFlowTotals.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'CashPreviewOutputBody':
      return CashPreviewOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'CashSessionsOutputBody':
      return CashSessionsOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
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
    case 'CloseCommand':
      return CloseCommand.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ClosePreview':
      return ClosePreview.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'CloseSelection':
      return CloseSelection.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ClosedReconciliation':
      return ClosedReconciliation.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Command':
      return Command.fromJson(value as Map<String, dynamic>) as ReturnType;
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
    case 'DailyPoint':
      return DailyPoint.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DetailOutputBody':
      return DetailOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'GenderChoice':
      return GenderChoice.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'GenderData':
      return GenderData.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'GenderOutputBody':
      return GenderOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'GroupRow':
      return GroupRow.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'HealthOutputBody':
      return HealthOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'HistoryOutputBody':
      return HistoryOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Item':
      return Item.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ListOutputBody':
      return ListOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'LoginRequest':
      return LoginRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'LoginResponse':
      return LoginResponse.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'LoginResponseData':
      return LoginResponseData.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Meta':
      return Meta.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MetaStruct':
      return MetaStruct.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MethodRow':
      return MethodRow.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MethodSummary':
      return MethodSummary.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'MovementCapabilities':
      return MovementCapabilities.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'MovementDetail':
      return MovementDetail.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'MovementDetailOutputBody':
      return MovementDetailOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'MovementOutputBody':
      return MovementOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'MovementProofOutputBody':
      return MovementProofOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'MovementRecord':
      return MovementRecord.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Mutation':
      return Mutation.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OTPResponse':
      return OTPResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OTPResponseData':
      return OTPResponseData.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'OpenRequest':
      return OpenRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Order':
      return Order.fromJson(value as Map<String, dynamic>) as ReturnType;
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
    case 'OutputBody':
      return OutputBody.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'PaginationMeta':
      return PaginationMeta.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Preview':
      return Preview.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'PreviewOutputBody':
      return PreviewOutputBody.fromJson(value as Map<String, dynamic>)
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
    case 'ProofLink':
      return ProofLink.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ReceiptItem':
      return ReceiptItem.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ReceiptSnapshot':
      return ReceiptSnapshot.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ReconciliationSummary':
      return ReconciliationSummary.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Refund':
      return Refund.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'RefundItem':
      return RefundItem.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'RefundOutputBody':
      return RefundOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'RegisterRequest':
      return RegisterRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Report':
      return Report.fromJson(value as Map<String, dynamic>) as ReturnType;
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
    case 'Result':
      return Result.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ReversalCommand':
      return ReversalCommand.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'SelectedItem':
      return SelectedItem.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Selection':
      return Selection.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'SessionData':
      return SessionData.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'SessionRecord':
      return SessionRecord.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'SessionResponse':
      return SessionResponse.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'StatusError':
      return StatusError.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'StockCommand':
      return StockCommand.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'StockHistoryOutputBody':
      return StockHistoryOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'StockMovement':
      return StockMovement.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'StockWriteOutputBody':
      return StockWriteOutputBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
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
    case 'Totals':
      return Totals.fromJson(value as Map<String, dynamic>) as ReturnType;
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
