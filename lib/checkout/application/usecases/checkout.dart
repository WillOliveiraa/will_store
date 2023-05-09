import 'package:will_store/catalog/application/repositories/product_repository.dart';
import 'package:will_store/freight/domain/freight_calculate.dart';

import '../../domain/entities/order.dart';
import '../repositories/coupon_repository.dart';

class Checkout {
  final ProductRepository productRepository;
  final CouponRepository couponRepository;

  Checkout(this.productRepository, this.couponRepository);

  Future<Map<String, Object>> call(Map<String, dynamic> input) async {
    final order =
        Order(id: input['id'], cpf: input['cpf'], date: input['date']);
    if (!input.containsKey('items') || (input['items'] as List).isEmpty) {
      throw ArgumentError("Invalid items");
    }
    num freight = 0;
    for (final Map<String, dynamic> item in input['items']) {
      if (!item.containsKey('quantity') || item['quantity'] <= 0) {
        throw ArgumentError("Invalid quantity");
      }
      final product = await productRepository.getProductById(item['idProduct']);
      order.addItem(product, item['quantity']);
      final itemFreight = FreightCalculate.calculate(product, item['quantity']);
      freight += itemFreight;
    }
    if (input.containsKey('from') && input.containsKey('to')) {
      order.freight = freight;
    }
    if (input.containsKey('coupon')) {
      final coupon = await couponRepository.getCoupon(input['coupon']);
      if (coupon == null) throw ArgumentError("Coupon not found");
      order.addCoupon(coupon);
    }
    final num total = order.getTotal();
    return {"total": total, "freight": freight};
  }
}
