import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:will_store/auth/domain/entities/email.dart';

void main() {
  test('Deve validar um e-mail válido', () {
    const input = 'will@teste.com';
    final email = Email(input);
    expect(email.valid, isTrue);
    expect(email.value, equals(input));
  });

  parameterizedTest(
    'Deve validar e-mails inválidos',
    [
      "",
      " ",
      "will",
      "will@.",
      "will@asda",
      "willasda.com",
    ],
    p1((String value) {
      expect(
          () async => Email(value),
          throwsA(isA<ArgumentError>()
              .having((error) => error.message, "message", "Invalid email")));
    }),
  );
}
