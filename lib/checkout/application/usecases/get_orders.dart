import 'package:will_store/checkout/application/repositories/order_repository.dart';
import 'package:will_store/checkout/domain/entities/order.dart';

import '../factories/repository_factory.dart';

class GetOrders {
  late OrderRepository _orderRepository;

  GetOrders(RepositoryFactory repositoryFactory) {
    _orderRepository = repositoryFactory.createOrderRepository();
  }

  Future<List<Order>> call() async {
    return await _orderRepository.getOrders();
  }
}
