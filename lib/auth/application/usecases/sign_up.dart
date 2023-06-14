import '../../domain/entities/user.dart';
import '../../infra/models/user_model.dart';
import '../../infra/repositories/user_repository_database.dart';
import '../models/sign_up_input.dart';

class SignUp {
  final UserRepositoryDatabase userRepository;

  SignUp(this.userRepository);

  Future<Map<String, dynamic>> call(SignUpInput input) async {
    if (!isValid(input.email)) {
      throw ArgumentError('Invalid email');
    }
    final user = User.create(input.email, input.password, input.username);
    final output = await userRepository.signUp(user);
    final newUser = UserModel(
      id: output['userId'],
      username: input.username,
      email: input.email,
    );
    await userRepository.save(newUser);
    return output;
  }

  bool isValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
