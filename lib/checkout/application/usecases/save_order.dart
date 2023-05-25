import '../../domain/entities/order.dart';
import '../factories/repository_factory.dart';
import '../repositories/order_repository.dart';

class SaveOrder {
  late OrderRepository _orderRepository;

  SaveOrder(RepositoryFactory repositoryFactory) {
    _orderRepository = repositoryFactory.createOrderRepository();
  }

  Future<void> call(Order order) async {
    await _orderRepository.save(order);
  }
}
