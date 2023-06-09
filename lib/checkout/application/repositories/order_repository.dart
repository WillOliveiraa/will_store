import '../../domain/entities/order.dart';

abstract class OrderRepository {
  Future<int> count();
  Future<void> save(Order order);
  Future<Order> getOrderById(String id);
  Future<List<Order>> getOrders();
}
