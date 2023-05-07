import 'package:will_store/domain/entities/product.dart';

import 'cpf.dart';
import 'item_order.dart';

class Order {
  final String? id;
  late final Cpf cpf;
  late final List<OrderItem> items;
  final int sequence;
  final DateTime date;
  // ignore: prefer_final_fields
  num _freight;

  Order({
    this.id,
    required cpf,
    this.sequence = 1,
    DateTime? date,
  })  : cpf = Cpf(cpf),
        date = date ?? DateTime.now(),
        items = [],
        _freight = 0;

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
    total += _freight;
    return total;
  }

  set freight(num value) => _freight = value;
}
