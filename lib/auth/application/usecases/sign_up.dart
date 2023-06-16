import 'package:will_store/checkout/infra/models/cpf_model.dart';

import '../../domain/entities/user.dart';
import '../../infra/models/email_model.dart';
import '../../infra/models/user_model.dart';
import '../../infra/repositories/user_repository_database.dart';
import '../models/sign_up_input.dart';

class SignUp {
  final UserRepositoryDatabase userRepository;

  SignUp(this.userRepository);

  Future<Map<String, dynamic>> call(SignUpInput input) async {
    final user = User.create(
      firstName: input.firstName,
      lastName: input.lastName,
      email: input.email,
      cpf: input.cpf,
      password: input.password,
    );
    final output = await userRepository.signUp(user);
    final newUser = UserModel(
      id: output['userId'],
      firstName: input.firstName,
      lastName: input.lastName,
      email: EmailModel(input.email),
      cpf: CpfModel(input.cpf),
    );
    await userRepository.save(newUser);
    return output;
  }
}
