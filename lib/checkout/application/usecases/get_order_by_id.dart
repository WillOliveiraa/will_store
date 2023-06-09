import '../../domain/entities/order.dart';
import '../factories/repository_factory.dart';
import '../repositories/order_repository.dart';

class GetOrderById {
  late OrderRepository _orderRepository;

  GetOrderById(RepositoryFactory repositoryFactory) {
    _orderRepository = repositoryFactory.createOrderRepository();
  }

  Future<Order> call(String id) async {
    return await _orderRepository.getOrderById(id);
  }
}
