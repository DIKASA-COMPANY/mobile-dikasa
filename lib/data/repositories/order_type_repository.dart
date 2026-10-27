import 'package:mobile_dikasa/data/models/order_type.dart';
import 'package:mobile_dikasa/data/services/order_type_service.dart';

class OrderTypeRepository {
  OrderTypeRepository({required OrderTypeService orderTypeService})
    : _orderTypeService = orderTypeService;

  final OrderTypeService _orderTypeService;
  List<OrderType>? _cache;

  Future<List<OrderType>> getOrderTypes({bool forceRefresh = false}) async {
    if (!forceRefresh && _cache != null) {
      return _cache!;
    }
    _cache = await _orderTypeService.fetchOrderTypes();
    return _cache!;
  }
}
