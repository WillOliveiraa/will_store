import '../../domain/entities/cart_item.dart';
import '../repositories/user_repository.dart';

class GetItemsFromCart {
  final UserRepository _repository;

  GetItemsFromCart(this._repository);

  Future<List<CartItem>> call(String input) async {
    return await _repository.getItemsFromCart(input);
  }
}
