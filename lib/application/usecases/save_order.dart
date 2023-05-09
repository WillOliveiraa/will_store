import '../../domain/entities/order.dart';
import '../repositories/order_repository.dart';

class SaveOrder {
  final OrderRepository _repository;

  SaveOrder(this._repository);

  Future<void> call(Order order) async {
    await _repository.save(order);
  }
}
