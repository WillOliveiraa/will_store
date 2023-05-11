import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/freight/domain/entities/zip_code.dart';

void main() {
  test('Deve criar um novo código postal', () {
    final zipCode = ZipCode(
        "22060030", "Rua Aires Saldanha", "Copacabana", -27.5945, -48.5477);
    expect(zipCode.code, equals("22060030"));
  });

  test('Não deve criar um código postal com código inválida', () {
    expect(
        () => ZipCode(
            " ", "Rua Aires Saldanha", "Copacabana", -27.5945, -48.5477),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, "message", "Invalid code")));
  });

  test('Não deve criar um código postal com rua inválida', () {
    expect(
        () => ZipCode("22060030", " ", "Copacabana", -27.5945, -48.5477),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, "message", "Invalid street")));
  });

  test('Não deve criar um código postal com bairro inválido', () {
    expect(
        () =>
            ZipCode("22060030", "Rua Aires Saldanha", " ", -27.5945, -48.5477),
        throwsA(isA<ArgumentError>().having(
            (error) => error.message, "message", "Invalid neighborhood")));
  });
}
