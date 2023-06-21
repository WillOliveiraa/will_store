import '../../domain/entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class AddCartItem {
  final CartRepository _repository;

  AddCartItem(this._repository);

  Future<void> call(CartItem cartItem, String userId) async {
    await _repository.addCartItem(cartItem, userId);
  }
}
