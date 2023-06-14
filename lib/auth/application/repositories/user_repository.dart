import '../../domain/entities/user.dart';
import '../models/login_input.dart';

abstract class UserRepository {
  Future<void> save(User user);
  Future<Map<String, dynamic>> signUp(User user);
  Future<User?> login(LoginInput input);
  Future<User> getCurrentUser(String userId);
}
