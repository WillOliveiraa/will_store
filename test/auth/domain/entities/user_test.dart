import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/auth/domain/entities/user.dart';

void main() {
  const Map<String, dynamic> input = {
    'id': '1',
    'username': 'Willian Oliveira',
    'email': 'will@teste.com',
    'password': '123123',
  };

  test('Deve validar um usuário', () {
    final user = User(username: input['username'], email: input['email']);
    expect(user.id, equals('1'));
  });
}
