import 'package:will_store/domain/entities/coupon.dart';
import 'package:will_store/domain/entities/product.dart';

import 'cpf.dart';
import 'order_item.dart';

class Order {
  final String? id;
  late final Cpf cpf;
  late final List<OrderItem> items;
  final int sequence;
  final DateTime date;
  Coupon? _coupon;
  // ignore: prefer_final_fields
  num _freight;
  final String _code;

  Order({
    this.id,
    required cpf,
    this.sequence = 1,
    DateTime? date,
  })  : cpf = Cpf(cpf),
        date = date ?? DateTime.now(),
        items = [],
        _freight = 0,
        _code =
            "${date?.year.toString()}${sequence.toString().padLeft(8, "0")}";

  void addItem(Product product, int quantity) {
    if (items.where((item) => item.productId == product.id).isNotEmpty) {
      throw ArgumentError("Duplicated item");
    }
    items.add(OrderItem(product.id!, product.itemSize.first.price, quantity));
  }

  num getTotal() {
    num total = 0;
    for (final item in items) {
      total += item.price * item.quantity;
    }
    if (_coupon != null) {
      total -= _coupon!.calculateDiscount(total);
    }
    total += _freight;
    return total;
  }

  // ignore: unnecessary_getters_setters
  num get freight => _freight;

  set freight(num value) => _freight = value;

  void addCoupon(Coupon coupon) {
    if (!coupon.isExpired(date)) _coupon = coupon;
  }

  String get code => _code;
}
