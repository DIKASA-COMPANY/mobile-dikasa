import 'package:dikasa_api/dikasa_api.dart' as generated;
import 'package:dio/dio.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/order_type.dart';

class OrderTypeService {
  const OrderTypeService(this._apiClient);

  final ApiClient _apiClient;

  Future<List<OrderType>> fetchOrderTypes() async {
    try {
      final Response<generated.OrderTypesOutputBody> response = await _apiClient
          .api
          .getJenisOrderApi()
          .listOrderTypes();
      final generated.OrderTypesOutputBody? body = response.data;
      if (body == null) {
        throw const ApiException(
          type: ApiErrorType.parsing,
          message: 'Data jenis order dari server tidak lengkap.',
        );
      }

      return (body.data ?? const <generated.OrderTypeData>[])
          .map(
            (generated.OrderTypeData item) =>
                OrderType(id: item.id, code: item.code, label: item.name),
          )
          .toList(growable: false);
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }
}
