import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/catalog_product.dart';
import 'package:mobile_dikasa/data/services/catalog_service.dart';

const productJson = <String, dynamic>{
  'id': 'p1',
  'name': 'Nasi',
  'selling_price': 12000,
  'online_selling_price': 15000,
  'cost_price': 7000,
  'stock_status': 'available',
  'description': 'Catatan',
  'category': {'id': 'c1', 'name': 'Utama', 'is_active': true},
  'product_type': 'food',
  'is_active': true,
  'is_highlighted': true,
  'sort_order': 8,
  'variations': [
    {
      'id': 'v1',
      'name': 'Jumbo',
      'selling_price': 18000,
      'cost_price': 9000,
      'stock_status': 'out_of_stock',
      'sort_order': 4,
      'is_active': true,
    },
  ],
};

void main() {
  late ApiClient client;
  late CatalogService service;
  setUp(() {
    dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    );
    client = ApiClient();
    service = CatalogService(client);
  });
  void respond(dynamic Function(RequestOptions) callback) {
    client.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (o, h) async {
          h.resolve(
            Response(
              requestOptions: o,
              statusCode: 200,
              data: await callback(o),
            ),
          );
        },
      ),
    );
  }

  test('loads every page without mixing list and total counts', () async {
    final pages = <int>[];
    respond((o) {
      pages.add(o.queryParameters['page'] as int);
      expect(o.queryParameters['page_size'], 100);
      return {
        'data': [productJson],
        'meta': {'total': 2},
      };
    });
    final products = await service.products();
    expect(products.length, 2);
    expect(pages, [1, 2]);
    expect(products.first.variations.first.costPrice, 9000);
  });
  test(
    'patch uses multipart and preserves commerce fields; unchanged variants omitted',
    () async {
      respond((o) {
        expect(o.method, 'PATCH');
        expect(o.path, '/products/p1');
        final fields = Map.fromEntries((o.data as FormData).fields);
        expect(fields['selling_price'], '12000');
        expect(fields['cost_price'], '7000');
        expect(fields['is_highlighted'], 'true');
        expect(fields['sort_order'], '8');
        expect(fields.containsKey('online_cost_price'), isFalse);
        expect((o.data as FormData).files, isEmpty);
        return {'data': productJson};
      });
      await service.saveProduct(CatalogProduct.fromJson(productJson), id: 'p1');
    },
  );
  test(
    'explicit variation edits use JSON multipart part including empty list',
    () async {
      var call = 0;
      respond((o) async {
        final part = (o.data as FormData).files.single;
        expect(part.key, 'variations');
        expect(part.value.contentType!.mimeType, 'application/json');
        final bytes = await part.value.finalize().fold<List<int>>(
          [],
          (a, b) => a..addAll(b),
        );
        final variants = jsonDecode(utf8.decode(bytes)) as List;
        if (call == 0) {
          expect(variants.single['cost_price'], 9000);
          expect((variants.single as Map).containsKey('id'), isFalse);
        } else {
          expect(variants, isEmpty);
        }
        call++;
        return {'data': productJson};
      });
      await service.saveProduct(
        CatalogProduct.fromJson(productJson),
        replaceVariations: true,
      );
      await service.saveProduct(
        CatalogProduct.fromJson({...productJson, 'variations': <dynamic>[]}),
        id: 'p1',
        replaceVariations: true,
      );
      expect(call, 2);
      final variant = CatalogProduct.fromJson(productJson).variations.single;
      expect(jsonDecode(jsonEncode(variant.toRequest()))['cost_price'], 9000);
      expect(variant.toRequest().containsKey('id'), isFalse);
    },
  );
  test('category patch keeps type path, ordering and active status', () async {
    respond((o) {
      expect(o.path, '/product-types/drink/categories/c2');
      expect(o.method, 'PATCH');
      expect(o.data, {'name': 'Dingin', 'sort_order': 6, 'is_active': true});
      return {
        'data': {'id': 'c2', ...o.data as Map<String, dynamic>},
      };
    });
    final result = await service.saveCategory(
      'drink',
      const CatalogCategory(id: 'c2', name: 'Dingin', sortOrder: 6),
    );
    expect(result.name, 'Dingin');
  });
  test('authorization rejection surfaces backend message', () async {
    client.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (o, h) {
          h.reject(
            DioException(
              requestOptions: o,
              type: DioExceptionType.badResponse,
              response: Response(
                requestOptions: o,
                statusCode: 403,
                data: {
                  'error': {'message': 'Hanya manager.'},
                },
              ),
            ),
          );
        },
      ),
    );
    await expectLater(
      service.saveProduct(CatalogProduct.fromJson(productJson)),
      throwsA(
        isA<ApiException>().having(
          (e) => e.message,
          'message',
          'Hanya manager.',
        ),
      ),
    );
  });

  test('photo multipart sends bytes and removal is explicit', () async {
    respond((o) {
      final data = o.data as FormData;
      expect(data.files.single.key, 'image');
      expect(data.files.single.value.filename, 'photo.png');
      expect(data.files.single.value.contentType!.mimeType, 'image/png');
      expect(Map.fromEntries(data.fields)['remove_image'], 'false');
      return {'data': productJson};
    });
    await service.saveProduct(
      CatalogProduct(
        name: 'Nasi',
        category: const CatalogCategory(id: 'c1', name: 'Utama'),
        productType: 'food',
        price: 10000,
        image: CatalogImage(
          name: 'photo.png',
          bytes: Uint8List.fromList([137, 80, 78, 71]),
          mimeType: 'image/png',
        ),
      ),
      id: 'p1',
    );
  });

  test(
    'lost save response is uncertain and never automatically retried',
    () async {
      var calls = 0;
      client.dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (o, h) {
            calls++;
            h.reject(
              DioException(
                requestOptions: o,
                type: DioExceptionType.receiveTimeout,
              ),
            );
          },
        ),
      );
      await expectLater(
        service.saveProduct(CatalogProduct.fromJson(productJson)),
        throwsA(isA<CatalogWriteUncertain>()),
      );
      expect(calls, 1);
    },
  );
}
