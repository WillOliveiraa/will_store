import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:will_store/catalog/infra/models/product_model.dart';
import 'package:will_store/checkout/domain/entities/order.dart';

import '../../../mocks/products_mock.dart';

void main() {
  test('Não deve criar um pedido com CPF inválido', () {
    const id = "1";
    const cpf = "406.302.170-27";
    expect(
        () async => Order(id: id, cpf: cpf, userId: '1'),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, "message", "Invalid cpf")));
  });

  test('Deve criar um pedido com CPF válido', () {
    const id = "1";
    const cpf = "407.302.170-27";
    final order = Order(id: id, cpf: cpf, userId: '1');
    expect(order.getTotal(), equals(0));
  });

  test('Deve criar um pedido com 3 produtos', () {
    const id = "1";
    const cpf = "407.302.170-27";
    final order = Order(id: id, cpf: cpf, userId: '1');
    order.addItem(ProductModel.fromMap(productsMock[0]), 1);
    order.addItem(ProductModel.fromMap(productsMock[1]), 1);
    order.addItem(ProductModel.fromMap(productsMock[2]), 1);
    expect(order.getTotal(), equals(5130));
  });

  parameterizedTest(
    'Não deve criar um pedido com a quantidade do produto menor ou igual a zero',
    [-2, 0],
    p1((int value) {
      const id = "1";
      const cpf = "407.302.170-27";
      final order = Order(id: id, cpf: cpf, userId: '1');
      expect(
          () async =>
              order.addItem(ProductModel.fromMap(productsMock[0]), value),
          throwsA(isA<ArgumentError>().having(
              (error) => error.message, "message", "Invalid quantity")));
    }),
  );

  test('Não deve criar um pedido com o produto duplicado', () {
    const id = "1";
    const cpf = "407.302.170-27";
    final order = Order(id: id, cpf: cpf, userId: '1');
    order.addItem(ProductModel.fromMap(productsMock[0]), 1);
    expect(
        () async => order.addItem(ProductModel.fromMap(productsMock[0]), 1),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, "message", "Duplicated item")));
  });

  test('Deve criar um pedido e gerar um código', () {
    const id = "1";
    const cpf = "407.302.170-27";
    final order = Order(id: id, cpf: cpf, date: DateTime.now(), userId: '1');
    expect(order.code, equals("202300000001"));
  });
}
