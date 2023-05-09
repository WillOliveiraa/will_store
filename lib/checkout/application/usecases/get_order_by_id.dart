import '../repositories/order_repository.dart';

class GetOrderById {
  final OrderRepository repository;

  GetOrderById(this.repository);

  Future<Map<String, dynamic>> call(String id) async {
    return await repository.getOrderById(id);
  }
}
