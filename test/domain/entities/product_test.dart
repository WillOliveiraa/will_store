import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/domain/entities/product.dart';

void main() {
  test("Deve criar um novo produto", () {
    final product =
        Product("1", "Product test 1", "Product muito bom", null, "P");
    expect(product.id, equals("1"));
  });

  test("Não deve criar um produto com nome inválido", () {
    expect(
        () => Product("1", "", "Product muito bom", null, "P"),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, "message", "Invalid name")));
  });

  test("Não deve criar um produto com descrição inválida", () {
    expect(
        () => Product("1", "Product test 1", "", null, "P"),
        throwsA(isA<ArgumentError>().having(
            (error) => error.message, "message", "Invalid description")));
  });

  test("Não deve criar um produto com tamanho inválido", () {
    expect(
        () => Product("1", "Product test 1", "Product muito bom", null, ""),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, "message", "Invalid size")));
  });
}
