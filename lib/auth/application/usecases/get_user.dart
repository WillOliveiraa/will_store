import '../../domain/entities/user.dart';
import '../repositories/user_repository.dart';

class GetUser {
  final UserRepository _repository;

  GetUser(this._repository);

  Future<User> call(String userId) async {
    return await _repository.getCurrentUser(userId);
  }
}
