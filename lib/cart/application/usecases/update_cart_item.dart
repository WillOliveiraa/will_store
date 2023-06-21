import '../../domain/entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class UpdateCartItem {
  final CartRepository _repository;

  UpdateCartItem(this._repository);

  Future<void> call(CartItem cartItem, String userId) async {
    return await _repository.updateCartItem(cartItem, userId);
  }
}
