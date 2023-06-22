import 'package:will_store/checkout/application/repositories/order_repository.dart';
import 'package:will_store/checkout/domain/entities/order.dart';

import '../factories/repository_factory.dart';

class GetMyOrders {
  late OrderRepository _orderRepository;

  GetMyOrders(RepositoryFactory repositoryFactory) {
    _orderRepository = repositoryFactory.createOrderRepository();
  }

  Future<List<Order>> call(String userId) async {
    return await _orderRepository.getMyOrders(userId);
  }
}
