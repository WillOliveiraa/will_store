import 'package:will_store/auth/domain/entities/user.dart';

import '../models/login_input.dart';
import '../repositories/user_repository.dart';

class Login {
  final UserRepository userRepository;

  Login(this.userRepository);

  Future<User> call(LoginInput input) async {
    final userId = await userRepository.login(input);
    final user = userRepository.getCurrentUser(userId);
    return user;
  }
}
