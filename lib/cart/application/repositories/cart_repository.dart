import '../../domain/entities/cart_item.dart';

abstract class CartRepository {
  Future<List<CartItem>> getItemsFromCart(String userId);
  Future<void> updateCartItem(CartItem cartItem, String userId);
  Future<void> addCartItem(CartItem cartItem, String userId);
  Future<void> removeCartItem(String cartItemId, String userId);
}
