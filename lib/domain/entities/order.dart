import 'package:will_store/domain/entities/product.dart';

import 'cpf.dart';
import 'item_order.dart';

class Order {
  final String? id;
  late final Cpf cpf;
  late final List<OrderItem> items;
  final int sequence;
  final DateTime date;

  Order({
    this.id,
    required cpf,
    this.sequence = 1,
    DateTime? date,
  })  : cpf = Cpf(cpf),
        date = date ?? DateTime.now(),
        items = [];

  void addItem(Product product, int quantity) {
    items.add(OrderItem(product.id!, product.itemSize.first.price, quantity));
  }

  num getTotal() {
    num total = 0;
    for (final item in items) {
      total += item.price * item.quantity;
    }
    return total;
  }
}
