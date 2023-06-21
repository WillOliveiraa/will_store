import '../../domain/entities/cart_item.dart';
import '../../domain/entities/user.dart';
import '../models/login_input.dart';

abstract class UserRepository {
  Future<void> save(User user);
  Future<Map<String, dynamic>> signUp(User user);
  Future<String> login(LoginInput input);
  Future<User> getCurrentUser(String userId);
  Future<List<CartItem>> getItemsFromCart(String userId);
}
