import '../repositories/cart_repository.dart';

class RemoveCartItem {
  final CartRepository _repository;

  RemoveCartItem(this._repository);

  Future<void> call(String cartItemId, String userId) async {
    await _repository.removeCartItem(cartItemId, userId);
  }
}
