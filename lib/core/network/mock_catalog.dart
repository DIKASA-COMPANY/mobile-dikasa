import 'dart:convert';
import 'mock_workbook.dart';
import 'package:dio/dio.dart';

/// Session-local demo catalog. Never used when USE_MOCK_API=false.
class MockCatalog {
  MockCatalog(List<Map<String, dynamic>> source) {
    for (final row in source) {
      final type = row['group'] == 'minuman'
          ? 'drink'
          : row['group'] == 'tambahan'
          ? 'additional'
          : 'food';
      final name = row['category'] as String;
      var category = categories
          .where((c) => c['type'] == type && c['name'] == name)
          .firstOrNull;
      if (category == null) {
        category = {
          'id': 'mc${categories.length + 1}',
          'name': name,
          'type': type,
          'sort_order': 0,
          'is_active': true,
        };
        categories.add(category);
      }
      products.add({
        ...row,
        'category': category,
        'product_type': type,
        'selling_price': row['price'],
        'stock_status': 'available',
        'description': '',
        'sort_order': 0,
        'is_active': true,
        'variations': <dynamic>[],
      });
    }
  }
  final List<Map<String, dynamic>> products = [], categories = [];
  int serial = 0;
  final Map<String, Map<String, dynamic>> stockRequests = {};
  final Map<String, List<Map<String, dynamic>>> movements = {};
  String availability(Map<String, dynamic> p) =>
      p["stock_status"] == "out_of_stock" ||
          (p["track_stock"] == true && (p["stock_quantity"] as num? ?? 0) <= 0)
      ? "out_of_stock"
      : p["track_stock"] == true &&
            (p["stock_quantity"] as num? ?? 0) <=
                (p["low_stock_threshold"] as num? ?? 0)
      ? "low_stock"
      : "available";
  Future<bool> handle(
    RequestOptions o,
    RequestInterceptorHandler handler,
  ) async {
    void resolve(dynamic data, [int status = 200]) => handler.resolve(
      Response(requestOptions: o, statusCode: status, data: data),
    );
    void reject(String message, int status) => handler.reject(
      DioException(
        requestOptions: o,
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: o,
          statusCode: status,
          data: {
            'error': {'message': message},
          },
        ),
      ),
    );
    if (o.path == '/products/export.xlsx') {
      final q = o.queryParameters;
      final matches = products
          .where(
            (p) =>
                (q['include_inactive'] == true || p['is_active'] == true) &&
                (q['product_id'] == null || q['product_id'] == p['id']) &&
                (q['product_type'] == null ||
                    q['product_type'] == p['product_type']) &&
                (q['category_id'] == null ||
                    q['category_id'] == (p['category'] as Map)['id']) &&
                (q['availability'] == null ||
                    q['availability'] == availability(p)) &&
                (p['name'] as String).toLowerCase().contains(
                  (q['searchByProductName'] as String? ?? '').toLowerCase(),
                ),
          )
          .toList();
      resolve(mockProductWorkbook(matches));
      return true;
    }
    final stockMatch = RegExp(
      r'^/products/([^/]+)/(stock|stock-adjustments|stock-movements)$',
    ).firstMatch(o.path);
    if (stockMatch != null) {
      final id = stockMatch[1]!, kind = stockMatch[2]!;
      final p = products.where((p) => p['id'] == id).firstOrNull;
      if (p == null) {
        reject('Produk tidak ditemukan.', 404);
        return true;
      }
      final history = movements.putIfAbsent(id, () => []);
      if (kind == 'stock-movements') {
        final page = o.queryParameters['page'] as int? ?? 1;
        resolve({
          'data': history.skip((page - 1) * 20).take(20).toList(),
          'meta': {'total': history.length, 'page': page, 'page_size': 20},
        });
        return true;
      }
      final cmd = Map<String, dynamic>.from(o.data as Map);
      final request = cmd['request_id'] as String;
      final fingerprint = jsonEncode([id, kind, cmd]);
      final previous = stockRequests[request];
      if (previous != null) {
        if (previous['fingerprint'] != fingerprint) {
          reject('ID perintah sudah digunakan.', 409);
        } else {
          resolve({'data': previous['data']});
        }
        return true;
      }
      final before = (p['stock_quantity'] as num? ?? 0).toInt();
      var balance = before;
      if (kind == 'stock-adjustments') {
        final delta = (cmd['quantity_delta'] as num?)?.toInt() ?? 0;
        if (p['track_stock'] != true ||
            delta == 0 ||
            before + delta < 0 ||
            before + delta > 1000000000) {
          reject('Stok tidak cukup atau perubahan tidak valid.', 409);
          return true;
        }
        balance += delta;
      } else {
        if (cmd['track_stock'] == true && p['track_stock'] != true) {
          final initial = cmd['initial_quantity'] as num?;
          if (initial == null || initial < 0 || initial > 1000000000) {
            reject('Jumlah awal tidak valid.', 422);
            return true;
          }
          balance = initial.toInt();
        } else if (cmd.containsKey('initial_quantity')) {
          reject('Stok sudah berubah. Muat ulang.', 409);
          return true;
        }
        p['track_stock'] = cmd['track_stock'];
        p['low_stock_threshold'] =
            cmd['low_stock_threshold'] ?? p['low_stock_threshold'] ?? 0;
      }
      p['stock_quantity'] = balance;
      p['effective_stock_status'] = availability(p);
      final row = <String, dynamic>{
        'id': 'movement-${++serial}',
        'product_id': id,
        'request_id': request,
        'kind': kind == 'stock' ? 'configure' : 'adjust',
        'reason': cmd['reason'],
        'quantity_delta': balance - before,
        'balance_after': balance,
        'track_stock': p['track_stock'],
        'low_stock_threshold': p['low_stock_threshold'] ?? 0,
        'created_at': DateTime.now().toUtc().toIso8601String(),
      };
      history.insert(0, row);
      stockRequests[request] = {'fingerprint': fingerprint, 'data': row};
      resolve({'data': row});
      return true;
    }
    if (o.path == '/product-types') {
      resolve({
        'data': [
          {'id': 'mt1', 'code': 'food', 'name': 'Makanan'},
          {'id': 'mt2', 'code': 'drink', 'name': 'Minuman'},
          {'id': 'mt3', 'code': 'additional', 'name': 'Tambahan'},
        ],
      });
      return true;
    }
    final categoryMatch = RegExp(
      r'^/product-types/(food|drink|additional)/categories(?:/([^/]+))?$',
    ).firstMatch(o.path);
    if (categoryMatch != null) {
      final type = categoryMatch[1]!, id = categoryMatch[2];
      if (o.method == 'GET') {
        resolve({
          'data': categories
              .where((c) => c['type'] == type && c['is_active'] == true)
              .toList(),
        });
      } else if (o.method == 'POST' || o.method == 'PATCH') {
        final value = <String, dynamic>{
          ...o.data as Map<String, dynamic>,
          'type': type,
          'id': id ?? 'new-category-${++serial}',
        };
        if (id != null) {
          final index = categories.indexWhere(
            (c) => c['id'] == id && c['type'] == type,
          );
          if (index < 0) {
            reject('Kategori tidak ditemukan.', 404);
            return true;
          }
          categories[index] = value;
          for (final p in products) {
            if ((p['category'] as Map)['id'] == id) p['category'] = value;
          }
        } else {
          categories.add(value);
        }
        resolve({'data': value}, id == null ? 201 : 200);
      } else {
        reject('Metode tidak didukung.', 405);
      }
      return true;
    }
    if (o.path != '/products' && !o.path.startsWith('/products/')) return false;
    final id = o.path == '/products'
        ? null
        : o.path.substring('/products/'.length);
    if (o.method == 'GET') {
      for (final p in products) {
        p["effective_stock_status"] = availability(p);
      }
      final results = products
          .where(
            (p) =>
                o.queryParameters['include_inactive'] == true ||
                p['is_active'] == true,
          )
          .toList();
      if (id != null) {
        final product = results.where((p) => p['id'] == id).firstOrNull;
        if (product == null) {
          reject('Produk tidak ditemukan.', 404);
        } else {
          resolve({'data': product});
        }
      } else {
        final page = o.queryParameters['page'] as int? ?? 1,
            size = o.queryParameters['page_size'] as int? ?? 100;
        resolve({
          'data': results.skip((page - 1) * size).take(size).toList(),
          'meta': {'total': results.length, 'page': page, 'page_size': size},
        });
      }
    } else if (o.method == 'POST' || o.method == 'PATCH') {
      final index = products.indexWhere((p) => p['id'] == id);
      if (id != null && index < 0) {
        reject('Produk tidak ditemukan.', 404);
        return true;
      }
      final form = o.data as FormData;
      final fields = Map.fromEntries(form.fields);
      final category = categories
          .where(
            (c) =>
                c['id'] == fields['category_id'] &&
                c['type'] == fields['product_type'],
          )
          .firstOrNull;
      if (category == null) {
        reject('Kategori tidak sesuai jenis produk.', 422);
        return true;
      }
      final value = <String, dynamic>{
        if (index >= 0) ...products[index],
        ...fields,
        'id': id ?? 'new-product-${++serial}',
        'category': category,
        'selling_price': int.parse(fields['selling_price']!),
        'price': int.parse(fields['selling_price']!),
        'sort_order': int.parse(fields['sort_order'] ?? '0'),
        'is_highlighted': fields['is_highlighted'] == 'true',
        'is_active': fields['is_active'] != 'false',
      };
      for (final key in [
        'online_selling_price',
        'cost_price',
        'online_cost_price',
      ]) {
        if (fields.containsKey(key)) value[key] = int.parse(fields[key]!);
      }
      for (final part in form.files.where((f) => f.key == 'variations')) {
        final bytes = await part.value.finalize().fold<List<int>>(
          [],
          (a, b) => a..addAll(b),
        );
        value['variations'] = jsonDecode(utf8.decode(bytes));
      }
      value['variations'] ??= <dynamic>[];
      value.remove('group');
      if (fields['remove_image'] == 'true') value['image_url'] = null;
      for (final part in form.files.where((f) => f.key == 'image')) {
        final bytes = await part.value.finalize().fold<List<int>>(
          [],
          (a, b) => a..addAll(b),
        );
        value['image_url'] =
            'data:${part.value.contentType!.mimeType};base64,${base64Encode(bytes)}';
      }
      value['variations'] = (value['variations'] as List)
          .map(
            (v) => <String, dynamic>{
              ...v as Map<String, dynamic>,
              'id': v['id'] ?? 'variant-${++serial}',
              'is_active': v['is_active'] ?? true,
            },
          )
          .toList();
      value['effective_stock_status'] = availability(value);

      if (index >= 0) {
        products[index] = value;
      } else {
        products.add(value);
      }
      resolve({'data': value}, id == null ? 201 : 200);
    } else if (o.method == 'DELETE') {
      for (final p in products.where((p) => p['id'] == id)) {
        p['is_active'] = false;
      }
      resolve(null, 204);
    } else {
      reject('Metode tidak didukung.', 405);
    }
    return true;
  }

  String? applySale(Map<String, dynamic> payload) {
    final grouped = <String, int>{};
    for (final item in payload['items'] as List) {
      final p = products
          .where((p) => p['id'] == item['product_id'])
          .firstOrNull;
      if (p == null ||
          p['is_active'] != true ||
          p['stock_status'] == 'out_of_stock') {
        return 'Produk tidak tersedia.';
      }
      var price = p['selling_price'];
      if (item['product_variant_id'] != null) {
        final v = (p['variations'] as List)
            .where(
              (v) =>
                  v['id'] == item['product_variant_id'] &&
                  v['is_active'] != false &&
                  v['stock_status'] != 'out_of_stock',
            )
            .firstOrNull;
        if (v == null) return 'Variasi tidak tersedia.';
        price = v['selling_price'];
      }
      if (price != item['unit_price']) return 'Harga berubah. Periksa pesanan.';
      grouped[p['id'] as String] =
          (grouped[p['id']] ?? 0) + (item['quantity'] as num).toInt();
    }
    for (final e in grouped.entries) {
      final p = products.firstWhere((p) => p['id'] == e.key);
      if (p['track_stock'] == true && e.value > (p['stock_quantity'] as num)) {
        return 'Stok tidak cukup.';
      }
    }
    for (final e in grouped.entries) {
      final p = products.firstWhere((p) => p['id'] == e.key);
      if (p['track_stock'] != true) continue;
      p['stock_quantity'] = (p['stock_quantity'] as int) - e.value;
      p['effective_stock_status'] = availability(p);
      movements.putIfAbsent(e.key, () => []).insert(0, {
        'id': 'movement-${++serial}',
        'product_id': e.key,
        'kind': 'sale',
        'reason': 'Penjualan',
        'quantity_delta': -e.value,
        'balance_after': p['stock_quantity'],
        'created_at': DateTime.now().toUtc().toIso8601String(),
      });
    }
    return null;
  }

  void applyRefundReturn(
    Map<String, int> returns,
    String sale,
    String refund,
    String reason,
  ) {
    for (final e in returns.entries.where((e) => e.value > 0)) {
      final p = products.firstWhere((p) => p['id'] == e.key);
      if (p['track_stock'] != true ||
          (p['stock_quantity'] as int) > 1000000000 - e.value) {
        throw StateError('Invalid return');
      }
    }
    for (final e in returns.entries.where((e) => e.value > 0)) {
      final p = products.firstWhere((p) => p['id'] == e.key);
      p['stock_quantity'] = (p['stock_quantity'] as int) + e.value;
      p['effective_stock_status'] = availability(p);
      movements.putIfAbsent(e.key, () => []).insert(0, {
        'id': 'movement-${++serial}',
        'product_id': e.key,
        'transaction_id': sale,
        'refund_id': refund,
        'kind': 'refund_return',
        'reason': reason,
        'quantity_delta': e.value,
        'balance_after': p['stock_quantity'],
        'created_at': DateTime.now().toUtc().toIso8601String(),
      });
    }
  }
}
