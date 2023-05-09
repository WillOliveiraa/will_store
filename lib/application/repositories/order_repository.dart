import '../../domain/entities/order.dart';

abstract class OrderRepository {
  Future<int> count();
  Future<void> save(Order order);
  Future<Map<String, dynamic>> getOrderById(String id);
}
