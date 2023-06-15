import '../../domain/entities/user.dart';
import '../../infra/models/email_model.dart';
import '../../infra/models/user_model.dart';
import '../../infra/repositories/user_repository_database.dart';
import '../models/sign_up_input.dart';

class SignUp {
  final UserRepositoryDatabase userRepository;

  SignUp(this.userRepository);

  Future<Map<String, dynamic>> call(SignUpInput input) async {
    final user = User.create(input.email, input.password, input.username);
    final output = await userRepository.signUp(user);
    final newUser = UserModel(
      id: output['userId'],
      username: input.username,
      email: EmailModel(input.email),
    );
    await userRepository.save(newUser);
    return output;
  }
}
