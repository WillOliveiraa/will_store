import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:will_store/checkout/domain/entities/cpf.dart';

void main() {
  parameterizedTest(
    'Deve testar um CPF inválido',
    [
      "",
      "406.302.170-27",
      "406302170",
      "406302170123456789",
      "406302170123456789",
    ],
    p1((String value) {
      expect(
          () async => Cpf(value),
          throwsA(isA<ArgumentError>()
              .having((error) => error.message, "message", "Invalid cpf")));
    }),
  );

  parameterizedTest(
    'Deve testar um CPF inválido com todos os dígitos iguais',
    ["111.111.111-11", "222.222.222-22"],
    p1((String value) {
      expect(
          () async => Cpf(value),
          throwsA(isA<ArgumentError>()
              .having((error) => error.message, "message", "Invalid cpf")));
    }),
  );

  parameterizedTest(
    'Deve testar um CPF válido',
    ["407.302.170-27", "684.053.160-00", "746.971.314-01"],
    p1((String value) {
      final cpf = Cpf(value);
      expect(cpf.value, equals(value));
    }),
  );
}
