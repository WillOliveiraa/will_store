import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/catalog/domain/entities/dimentions.dart';
import 'package:will_store/catalog/domain/entities/item_size.dart';
import 'package:will_store/catalog/domain/entities/product.dart';

void main() {
  test("Deve criar um novo produto", () {
    final product = Product("1", "Product test 1", "Product muito bom", null,
        [ItemSize("1", "P", 19.99, 5, Dimentions("1", 100, 30, 10, 3))]);
    expect(product.id, equals("1"));
  });

  test("Não deve criar um produto com nome inválido", () {
    expect(
        () => Product("1", "", "Product muito bom", null,
            [ItemSize("1", "P", 19.99, 5, Dimentions("1", 100, 30, 10, 3))]),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, "message", "Invalid name")));
  });

  test("Não deve criar um produto com descrição inválida", () {
    expect(
        () => Product("1", "Product test 1", "", null,
            [ItemSize("1", "P", 19.99, 5, Dimentions("1", 100, 30, 10, 3))]),
        throwsA(isA<ArgumentError>().having(
            (error) => error.message, "message", "Invalid description")));
  });
}
