import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/freight/domain/entities/zip_code.dart';
import 'package:will_store/freight/infra/models/city_model.dart';
import 'package:will_store/freight/infra/models/uf_model.dart';

void main() {
  test('Deve criar um novo código postal', () {
    final zipCode = ZipCode(
        "22060030",
        "Rua Aires Saldanha",
        "Copacabana",
        CityModel(1, 123, "Rio de Janeiro"),
        UfModel("Rio de Janeiro", "RJ"),
        -27.5945,
        -48.5477);
    expect(zipCode.code, equals("22060030"));
  });

  test('Não deve criar um código postal com código inválida', () {
    expect(
        () => ZipCode(
            " ",
            "Rua Aires Saldanha",
            "Copacabana",
            CityModel(1, 123, "Rio de Janeiro"),
            UfModel("Rio de Janeiro", "RJ"),
            -27.5945,
            -48.5477),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, "message", "Invalid code")));
  });

  test('Não deve criar um código postal com rua inválida', () {
    expect(
        () => ZipCode(
            "22060030",
            " ",
            "Copacabana",
            CityModel(1, 123, "Rio de Janeiro"),
            UfModel("Rio de Janeiro", "RJ"),
            -27.5945,
            -48.5477),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, "message", "Invalid street")));
  });

  test('Não deve criar um código postal com bairro inválido', () {
    expect(
        () => ZipCode(
            "22060030",
            "Rua Aires Saldanha",
            " ",
            CityModel(1, 123, "Florianópolis"),
            UfModel("Santa Catarina", "SC"),
            -27.5945,
            -48.5477),
        throwsA(isA<ArgumentError>().having(
            (error) => error.message, "message", "Invalid neighborhood")));
  });
}
