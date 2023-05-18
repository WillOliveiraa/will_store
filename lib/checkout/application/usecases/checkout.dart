import 'package:will_store/catalog/application/repositories/product_repository.dart';
import 'package:will_store/checkout/application/repositories/order_repository.dart';
import 'package:will_store/freight/application/gateway/zip_code_gateway.dart';
import 'package:will_store/freight/application/models/calculate_freight_input.dart';
import 'package:will_store/freight/domain/entities/freight_calculate.dart';

import '../../../freight/application/models/calculate_freight_item.dart';
import '../../domain/entities/order.dart';
import '../repositories/coupon_repository.dart';

class Checkout {
  final ProductRepository _productRepository;
  final CouponRepository _couponRepository;
  final OrderRepository _orderRepository;
  final ZipCodeGateway _zipCodeGateway;

  Checkout(this._productRepository, this._couponRepository,
      this._orderRepository, this._zipCodeGateway);

  Future<Map<String, Object>> call(Map<String, dynamic> input) async {
    final sequence = await _orderRepository.count();
    final order = Order(
      id: input['id'],
      cpf: input['cpf'],
      sequence: sequence + 1,
      date: input['date'],
    );
    if (!input.containsKey('items') || (input['items'] as List).isEmpty) {
      throw ArgumentError("Invalid items");
    }
    final freightInput = CalculateFreightInput([], null, null);
    for (final Map<String, dynamic> item in input['items']) {
      if (!item.containsKey('quantity') || item['quantity'] <= 0) {
        throw ArgumentError("Invalid quantity");
      }
      final quantity = item['quantity'];
      final product =
          await _productRepository.getProductById(item['idProduct']);
      order.addItem(product, quantity);
      final dimentions = product.itemSize.first.dimentions;
      if (input.containsKey('from') && input.containsKey('to')) {
        final from = await _zipCodeGateway.getZipCode(input['from']);
        final to = await _zipCodeGateway.getZipCode(input['to']);
        freightInput.from = from;
        freightInput.to = to;
      }
      freightInput.items.add(CalculateFreightItem(dimentions.width,
          dimentions.height, dimentions.length, dimentions.weight, quantity));
    }
    final freight = FreightCalculate.calculate(freightInput);
    if (input.containsKey('from') && input.containsKey('to')) {
      order.freight = freight;
    }
    if (input.containsKey('coupon')) {
      final coupon = await _couponRepository.getCoupon(input['coupon']);
      if (coupon == null) throw ArgumentError("Coupon not found");
      order.addCoupon(coupon);
    }
    final num total = order.getTotal();
    await _orderRepository.save(order);
    return {"total": total, "freight": freight};
  }
}
