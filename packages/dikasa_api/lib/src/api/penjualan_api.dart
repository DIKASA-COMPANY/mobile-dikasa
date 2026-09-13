//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

// ignore: unused_import
import 'dart:convert';
import 'package:dikasa_api/src/deserialize.dart';
import 'package:dio/dio.dart';

import 'package:dikasa_api/src/model/customers_output_body.dart';
import 'package:dikasa_api/src/model/orders_output_body.dart';
import 'package:dikasa_api/src/model/status_error.dart';

class PenjualanApi {
  final Dio _dio;

  const PenjualanApi(this._dio);

  /// Daftar order outlet
  /// Mengambil transaksi terbaru sebagai daftar order outlet. Pencarian mencocokkan nomor nota atau nama pelanggan.
  ///
  /// Parameters:
  /// * [search]
  /// * [orderTypeId]
  /// * [status]
  /// * [page]
  /// * [pageSize]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [OrdersOutputBody] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<OrdersOutputBody>> listOrders({
    String? search,
    String? orderTypeId,
    String? status,
    int? page = 1,
    int? pageSize = 30,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/orders';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {'type': 'http', 'scheme': 'bearer', 'name': 'firebaseBearer'},
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (search != null) r'search': search,
      if (orderTypeId != null) r'order_type_id': orderTypeId,
      if (status != null) r'status': status,
      if (page != null) r'page': page,
      if (pageSize != null) r'page_size': pageSize,
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    OrdersOutputBody? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<OrdersOutputBody, OrdersOutputBody>(
              rawData,
              'OrdersOutputBody',
              growable: true,
            );
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<OrdersOutputBody>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// Daftar pelanggan terdaftar
  /// Mengambil pelanggan aktif outlet. Pencarian mencocokkan nama, nomor telepon, atau email.
  ///
  /// Parameters:
  /// * [search]
  /// * [genderId]
  /// * [page]
  /// * [pageSize]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [CustomersOutputBody] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<CustomersOutputBody>> listRegisteredCustomers({
    String? search,
    String? genderId,
    int? page = 1,
    int? pageSize = 30,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/customers';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {'type': 'http', 'scheme': 'bearer', 'name': 'firebaseBearer'},
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (search != null) r'search': search,
      if (genderId != null) r'gender_id': genderId,
      if (page != null) r'page': page,
      if (pageSize != null) r'page_size': pageSize,
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    CustomersOutputBody? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<CustomersOutputBody, CustomersOutputBody>(
              rawData,
              'CustomersOutputBody',
              growable: true,
            );
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<CustomersOutputBody>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }
}
