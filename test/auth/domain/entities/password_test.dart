import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:will_store/auth/domain/entities/password.dart';

void main() {
  test('Deve criar uma senha válida', () {
    const input = '123123';
    final password = Password(input);
    expect(password.valid, isTrue);
    expect(password.value, input);
  });

  parameterizedTest('Deve testar senhas inválidas', ['', ' ', '123', '12345'],
      p1((String value) {
    expect(
        () => Password(value),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, 'message', 'Invalid password')));
  }));
}
