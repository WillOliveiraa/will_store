import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:will_store/domain/entities/order_item.dart';

void main() {
  test('Deve criar um item do pedido', () {
    final item = OrderItem("1", 150, 1);
    expect(item.price, equals(150));
  });

  test('Não deve criar um item do pedido com id do produto inválido', () {
    expect(
        () => OrderItem("", 150, 1),
        throwsA(isA<ArgumentError>().having(
            (error) => error.message, "message", "Invalid product id")));
  });

  parameterizedTest(
    'Não deve criar um item do pedido com o preço menor ou igual a zero',
    [0, -1],
    p1((int value) {
      expect(
          () => OrderItem("1", value, 1),
          throwsA(isA<ArgumentError>()
              .having((error) => error.message, "message", "Invalid price")));
    }),
  );

  parameterizedTest(
    'Não deve criar um item do pedido com a quantidade menor ou igual a zero',
    [0, -1],
    p1((int value) {
      expect(
          () => OrderItem("1", 150, value),
          throwsA(isA<ArgumentError>().having(
              (error) => error.message, "message", "Invalid quantity")));
    }),
  );
}
