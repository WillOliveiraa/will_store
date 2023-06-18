import '../../domain/entities/user.dart';
import '../repositories/user_repository.dart';

class SaveUser {
  final UserRepository _repository;

  SaveUser(this._repository);

  Future<void> call(User user) async {
    await _repository.save(user);
  }
}
