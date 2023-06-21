import '../../domain/entities/cart_item.dart';

abstract class CartRepository {
  Future<List<CartItem>> getItemsFromCart(String userId);
  Future<void> updateCartItem(CartItem cartItem, String userId);
}
