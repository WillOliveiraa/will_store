import '../../domain/entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class GetItemsFromCart {
  final CartRepository _repository;

  GetItemsFromCart(this._repository);

  Future<List<CartItem>> call(String input) async {
    return await _repository.getItemsFromCart(input);
  }
}
