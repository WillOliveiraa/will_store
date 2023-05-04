import 'package:will_store/application/repositories/product_repository.dart';

import '../../domain/entities/order.dart';

class Checkout {
  final ProductRepository repository;

  Checkout(this.repository);

  Future<Map<String, Object>> call(Map<String, dynamic> input) async {
    final order =
        Order(id: input['id'], cpf: input['cpf'], date: input['date']);
    if (!input.containsKey('items') || (input['items'] as List).isEmpty) {
      throw ArgumentError("Invalid items");
    }
    for (final Map<String, dynamic> item in input['items']) {
      if (!item.containsKey('quantity') || item['quantity'] <= 0) {
        throw ArgumentError("Invalid quantity");
      }
      final product = await repository.getProductById(item['idProduct']);
      order.addItem(product, item['quantity']);
    }
    final num total = order.getTotal();
    return {"total": total};
  }
}
