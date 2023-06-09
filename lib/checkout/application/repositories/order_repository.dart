import '../../domain/entities/order.dart';

abstract class OrderRepository {
  Future<int> getOrderSequence();
  Future<void> save(Order order);
  Future<Order> getOrderById(String id);
  Future<List<Order>> getMyOrders(String userId);
  Future<List<Order>> getAllOrders();
}
