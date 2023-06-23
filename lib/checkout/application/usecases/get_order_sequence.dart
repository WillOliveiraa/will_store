import '../factories/repository_factory.dart';
import '../repositories/order_repository.dart';

class GetOrderSequence {
  late final OrderRepository _orderRepository;

  GetOrderSequence(RepositoryFactory repositoryFactory) {
    _orderRepository = repositoryFactory.createOrderRepository();
  }

  Future<int> call() async {
    return await _orderRepository.getOrderSequence();
  }
}
