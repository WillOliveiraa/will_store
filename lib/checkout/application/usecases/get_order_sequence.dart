import '../repositories/order_repository.dart';

class GetOrderSequence {
  final OrderRepository repository;

  GetOrderSequence(this.repository);

  Future<int> call() async {
    return await repository.count();
  }
}
