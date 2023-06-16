import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:will_store/auth/domain/entities/user.dart';

import '../../../mocks/user_mock.dart';

void main() {
  final userMock = usersMock.first;
  test('Deve criar um usuário válido', () {
    final user = User.create(
      firstName: userMock['firstName'],
      lastName: userMock['lastName'],
      email: userMock['email'],
      cpf: userMock['cpf'],
      password: userMock['password'],
      id: userMock['id'],
    );
    expect(user.id, '1');
    expect(user.email.value, userMock['email']);
    expect(user.email.valid, isTrue);
  });

  parameterizedTest(
      'Não deve criar um usuário com primeiro nome inválido', ['', ' '],
      p1((String value) {
    expect(
        () => User.create(
              firstName: value,
              lastName: userMock['lastName'],
              email: userMock['email'],
              cpf: userMock['cpf'],
              password: userMock['password'],
              id: userMock['id'],
            ),
        throwsA(isA<ArgumentError>().having(
            (error) => error.message, 'message', 'Invalid first name')));
  }));

  parameterizedTest(
      'Não deve criar um usuário com último nome inválido', ['', ' '],
      p1((String value) {
    expect(
        () => User.create(
              firstName: userMock['firstName'],
              lastName: value,
              email: userMock['email'],
              cpf: userMock['cpf'],
              password: userMock['password'],
              id: userMock['id'],
            ),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, 'message', 'Invalid last name')));
  }));
}
