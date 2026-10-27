//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

// ignore: unused_import
import 'dart:convert';
import 'package:dikasa_api/src/deserialize.dart';
import 'package:dio/dio.dart';

import 'package:dikasa_api/src/model/categories_output_body.dart';
import 'package:dikasa_api/src/model/category_output_body.dart';
import 'package:dikasa_api/src/model/category_request.dart';
import 'package:dikasa_api/src/model/product_output_body.dart';
import 'package:dikasa_api/src/model/product_types_output_body.dart';
import 'package:dikasa_api/src/model/product_variant_request.dart';
import 'package:dikasa_api/src/model/products_output_body.dart';
import 'package:dikasa_api/src/model/status_error.dart';

class KatalogApi {
  final Dio _dio;

  const KatalogApi(this._dio);

  /// Membuat produk
  /// Khusus manager. Multipart memakai product_type, selling_price, stock_status, harga online/modal opsional, variations JSON opsional, dan gambar PNG/JPEG opsional maksimal 3 MiB.
  ///
  /// Parameters:
  /// * [categoryId]
  /// * [name]
  /// * [productType]
  /// * [sellingPrice]
  /// * [stockStatus]
  /// * [costPrice]
  /// * [description]
  /// * [image]
  /// * [isActive]
  /// * [isHighlighted]
  /// * [onlineCostPrice]
  /// * [onlineSellingPrice]
  /// * [removeImage]
  /// * [sortOrder]
  /// * [variations]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ProductOutputBody] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ProductOutputBody>> createProduct({
    required String categoryId,
    required String name,
    required String productType,
    required int sellingPrice,
    required String stockStatus,
    int? costPrice,
    String? description,
    MultipartFile? image,
    bool? isActive,
    bool? isHighlighted,
    int? onlineCostPrice,
    int? onlineSellingPrice,
    bool? removeImage,
    int? sortOrder,
    List<ProductVariantRequest>? variations,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/products';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {'type': 'http', 'scheme': 'bearer', 'name': 'firebaseBearer'},
        ],
        ...?extra,
      },
      contentType: 'multipart/form-data',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      _bodyData = FormData.fromMap(<String, dynamic>{
        r'category_id': categoryId,
        if (costPrice != null) r'cost_price': costPrice,
        if (description != null) r'description': description,
        if (image != null) r'image': image,
        if (isActive != null) r'is_active': isActive,
        if (isHighlighted != null) r'is_highlighted': isHighlighted,
        r'name': name,
        if (onlineCostPrice != null) r'online_cost_price': onlineCostPrice,
        if (onlineSellingPrice != null)
          r'online_selling_price': onlineSellingPrice,
        r'product_type': productType,
        if (removeImage != null) r'remove_image': removeImage,
        r'selling_price': sellingPrice,
        if (sortOrder != null) r'sort_order': sortOrder,
        r'stock_status': stockStatus,
        r'variations': variations,
      });
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _options.compose(_dio.options, _path),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    ProductOutputBody? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<ProductOutputBody, ProductOutputBody>(
              rawData,
              'ProductOutputBody',
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

    return Response<ProductOutputBody>(
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

  /// Membuat kategori
  /// Khusus manager pada outlet terautentikasi.
  ///
  /// Parameters:
  /// * [productType]
  /// * [categoryRequest]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [CategoryOutputBody] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<CategoryOutputBody>> createProductCategory({
    required String productType,
    required CategoryRequest categoryRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/product-types/{product_type}/categories'.replaceAll(
      '{'
      r'product_type'
      '}',
      productType.toString(),
    );
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {'type': 'http', 'scheme': 'bearer', 'name': 'firebaseBearer'},
        ],
        ...?extra,
      },
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      _bodyData = jsonEncode(categoryRequest);
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _options.compose(_dio.options, _path),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    CategoryOutputBody? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<CategoryOutputBody, CategoryOutputBody>(
              rawData,
              'CategoryOutputBody',
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

    return Response<CategoryOutputBody>(
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

  /// Menonaktifkan produk
  /// Khusus manager. Soft delete mempertahankan object gambar.
  ///
  /// Parameters:
  /// * [productId]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future]
  /// Throws [DioException] if API call or serialization fails
  Future<Response<void>> deleteProduct({
    required String productId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/products/{product_id}'.replaceAll(
      '{'
      r'product_id'
      '}',
      productId.toString(),
    );
    final _options = Options(
      method: r'DELETE',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {'type': 'http', 'scheme': 'bearer', 'name': 'firebaseBearer'},
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return _response;
  }

  /// Menonaktifkan kategori
  /// Khusus manager; ditolak bila kategori masih memiliki produk aktif.
  ///
  /// Parameters:
  /// * [productType]
  /// * [categoryId]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future]
  /// Throws [DioException] if API call or serialization fails
  Future<Response<void>> deleteProductCategory({
    required String productType,
    required String categoryId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/product-types/{product_type}/categories/{category_id}'
        .replaceAll(
          '{'
          r'product_type'
          '}',
          productType.toString(),
        )
        .replaceAll(
          '{'
          r'category_id'
          '}',
          categoryId.toString(),
        );
    final _options = Options(
      method: r'DELETE',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {'type': 'http', 'scheme': 'bearer', 'name': 'firebaseBearer'},
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return _response;
  }

  /// Detail produk
  ///
  ///
  /// Parameters:
  /// * [productId]
  /// * [includeInactive]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ProductOutputBody] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ProductOutputBody>> getProduct({
    required String productId,
    bool? includeInactive = false,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/products/{product_id}'.replaceAll(
      '{'
      r'product_id'
      '}',
      productId.toString(),
    );
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
      if (includeInactive != null) r'include_inactive': includeInactive,
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    ProductOutputBody? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<ProductOutputBody, ProductOutputBody>(
              rawData,
              'ProductOutputBody',
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

    return Response<ProductOutputBody>(
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

  /// Daftar kategori sesuai tipe produk
  ///
  ///
  /// Parameters:
  /// * [productType]
  /// * [includeInactive]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [CategoriesOutputBody] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<CategoriesOutputBody>> listProductCategories({
    required String productType,
    bool? includeInactive = false,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/product-types/{product_type}/categories'.replaceAll(
      '{'
      r'product_type'
      '}',
      productType.toString(),
    );
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
      if (includeInactive != null) r'include_inactive': includeInactive,
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    CategoriesOutputBody? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<CategoriesOutputBody, CategoriesOutputBody>(
              rawData,
              'CategoriesOutputBody',
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

    return Response<CategoriesOutputBody>(
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

  /// Daftar tipe produk
  ///
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ProductTypesOutputBody] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ProductTypesOutputBody>> listProductTypes({
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/product-types';
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

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    ProductTypesOutputBody? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<ProductTypesOutputBody, ProductTypesOutputBody>(
              rawData,
              'ProductTypesOutputBody',
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

    return Response<ProductTypesOutputBody>(
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

  /// Daftar produk POS
  /// User outlet melihat produk aktif. Mencari nama produk secara case-insensitive dan partial melalui searchByProductName; include_inactive hanya untuk manager.
  ///
  /// Parameters:
  /// * [productType]
  /// * [categoryId]
  /// * [searchByProductName]
  /// * [page]
  /// * [pageSize]
  /// * [includeInactive]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ProductsOutputBody] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ProductsOutputBody>> listProducts({
    String? productType,
    String? categoryId,
    String? searchByProductName,
    int? page = 1,
    int? pageSize = 30,
    bool? includeInactive = false,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/products';
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
      if (productType != null) r'product_type': productType,
      if (categoryId != null) r'category_id': categoryId,
      if (searchByProductName != null)
        r'searchByProductName': searchByProductName,
      if (page != null) r'page': page,
      if (pageSize != null) r'page_size': pageSize,
      if (includeInactive != null) r'include_inactive': includeInactive,
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    ProductsOutputBody? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<ProductsOutputBody, ProductsOutputBody>(
              rawData,
              'ProductsOutputBody',
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

    return Response<ProductsOutputBody>(
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

  /// Memperbarui produk
  /// Khusus manager. Multipart parsial dapat mengganti daftar variations, mengganti image, atau menghapus image dengan remove_image.
  ///
  /// Parameters:
  /// * [productId]
  /// * [categoryId]
  /// * [costPrice]
  /// * [description]
  /// * [image]
  /// * [isActive]
  /// * [isHighlighted]
  /// * [name]
  /// * [onlineCostPrice]
  /// * [onlineSellingPrice]
  /// * [productType]
  /// * [removeImage]
  /// * [sellingPrice]
  /// * [sortOrder]
  /// * [stockStatus]
  /// * [variations]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ProductOutputBody] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ProductOutputBody>> updateProduct({
    required String productId,
    String? categoryId,
    int? costPrice,
    String? description,
    MultipartFile? image,
    bool? isActive,
    bool? isHighlighted,
    String? name,
    int? onlineCostPrice,
    int? onlineSellingPrice,
    String? productType,
    bool? removeImage,
    int? sellingPrice,
    int? sortOrder,
    String? stockStatus,
    List<ProductVariantRequest>? variations,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/products/{product_id}'.replaceAll(
      '{'
      r'product_id'
      '}',
      productId.toString(),
    );
    final _options = Options(
      method: r'PATCH',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {'type': 'http', 'scheme': 'bearer', 'name': 'firebaseBearer'},
        ],
        ...?extra,
      },
      contentType: 'multipart/form-data',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      _bodyData = FormData.fromMap(<String, dynamic>{
        if (categoryId != null) r'category_id': categoryId,
        if (costPrice != null) r'cost_price': costPrice,
        if (description != null) r'description': description,
        if (image != null) r'image': image,
        if (isActive != null) r'is_active': isActive,
        if (isHighlighted != null) r'is_highlighted': isHighlighted,
        if (name != null) r'name': name,
        if (onlineCostPrice != null) r'online_cost_price': onlineCostPrice,
        if (onlineSellingPrice != null)
          r'online_selling_price': onlineSellingPrice,
        if (productType != null) r'product_type': productType,
        if (removeImage != null) r'remove_image': removeImage,
        if (sellingPrice != null) r'selling_price': sellingPrice,
        if (sortOrder != null) r'sort_order': sortOrder,
        if (stockStatus != null) r'stock_status': stockStatus,
        r'variations': variations,
      });
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _options.compose(_dio.options, _path),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    ProductOutputBody? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<ProductOutputBody, ProductOutputBody>(
              rawData,
              'ProductOutputBody',
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

    return Response<ProductOutputBody>(
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

  /// Memperbarui kategori
  /// Khusus manager. Kategori dengan produk aktif tidak dapat dinonaktifkan.
  ///
  /// Parameters:
  /// * [productType]
  /// * [categoryId]
  /// * [categoryRequest]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [CategoryOutputBody] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<CategoryOutputBody>> updateProductCategory({
    required String productType,
    required String categoryId,
    required CategoryRequest categoryRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/product-types/{product_type}/categories/{category_id}'
        .replaceAll(
          '{'
          r'product_type'
          '}',
          productType.toString(),
        )
        .replaceAll(
          '{'
          r'category_id'
          '}',
          categoryId.toString(),
        );
    final _options = Options(
      method: r'PATCH',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {'type': 'http', 'scheme': 'bearer', 'name': 'firebaseBearer'},
        ],
        ...?extra,
      },
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      _bodyData = jsonEncode(categoryRequest);
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _options.compose(_dio.options, _path),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    CategoryOutputBody? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<CategoryOutputBody, CategoryOutputBody>(
              rawData,
              'CategoryOutputBody',
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

    return Response<CategoryOutputBody>(
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
