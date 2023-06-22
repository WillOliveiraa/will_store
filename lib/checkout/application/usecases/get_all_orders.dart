import 'package:will_store/checkout/application/repositories/order_repository.dart';
import 'package:will_store/checkout/domain/entities/order.dart';

import '../factories/repository_factory.dart';

class GetAllOrders {
  late OrderRepository _orderRepository;

  GetAllOrders(RepositoryFactory repositoryFactory) {
    _orderRepository = repositoryFactory.createOrderRepository();
  }

  Future<List<Order>> call() async {
    return await _orderRepository.getAllOrders();
  }
}
