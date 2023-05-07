import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:will_store/application/repositories/product_repository.dart';
import 'package:will_store/application/usecases/checkout.dart';
import 'package:will_store/infra/database/fake_farebase_adapter.dart';
import 'package:will_store/infra/repositories/product_repository_database.dart';

import '../../mocks/products_mock.dart';

void main() async {
  final connection = FakeFirebaseAdapter();
  late ProductRepository repository;
  late Checkout checkout;
  final List<Map<String, dynamic>> productsSnap = [];

  setUp(() {
    repository = ProductRepositoryDatabase(connection);
    checkout = Checkout(repository);
  });

  setUpAll(() async {
    final collection = connection.firestore.collection('products');
    for (int i = 0; i < productsMock.length; i++) {
      final snapshot = await collection.add(productsMock[i]);
      final productMock = productsMock[i];
      productMock['id'] = snapshot.id;
      productsSnap.add(productMock);
    }
  });

  parameterizedTest(
    'Não deve criar um pedido com cpf inválido',
    ["", "406.302.170-27"],
    p1((String value) {
      final Map<String, dynamic> input = {
        "cpf": value,
        "items": [],
      };
      expect(
          () async => await checkout(input),
          throwsA(isA<ArgumentError>()
              .having((error) => error.message, "message", "Invalid cpf")));
    }),
  );

  test("Deve criar um pedido com cpf válido", () async {
    final Map<String, dynamic> input = {
      "cpf": "407.302.170-27",
      "items": [
        {"idProduct": productsSnap[0]['id'], "quantity": 1}
      ],
    };
    final output = await checkout(input);
    expect(output['total'], equals(100));
  });

  test(
      "Não deve criar um pedido com a quantidade do produto menor ou igual a zero",
      () {
    final Map<String, dynamic> input = {
      "cpf": "407.302.170-27",
      "items": [
        {"idProduct": productsSnap[0]['id'], "quantity": 0},
      ],
    };
    expect(
        () async => await checkout(input),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, "message", "Invalid quantity")));
  });

  parameterizedTest(
    'Não deve criar um pedido sem produtos',
    [
      {"cpf": "407.302.170-27"},
      {"cpf": "407.302.170-27", "items": []}
    ],
    p1((Map<String, dynamic> value) {
      expect(
          () async => await checkout(value),
          throwsA(isA<ArgumentError>()
              .having((error) => error.message, "message", "Invalid items")));
    }),
  );

  test("Não deve criar um pedido com produto não encontrado", () {
    final Map<String, dynamic> input = {
      "cpf": "407.302.170-27",
      "items": [
        {"idProduct": "1", "quantity": 1},
      ],
    };
    expect(
        () async => await checkout(input),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, "message", "Product not found")));
  });

  test("Não deve criar um pedido com produto duplicado", () {
    final Map<String, dynamic> input = {
      "cpf": "407.302.170-27",
      "items": [
        {"idProduct": productsSnap[0]['id'], "quantity": 1},
        {"idProduct": productsSnap[0]['id'], "quantity": 1},
      ],
    };
    expect(
        () async => await checkout(input),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, "message", "Duplicated item")));
  });

  test("Deve criar um pedido com 3 produtos", () async {
    final Map<String, dynamic> input = {
      "cpf": "407.302.170-27",
      "items": [
        {"idProduct": productsSnap[0]['id'], "quantity": 3},
        {"idProduct": productsSnap[1]['id'], "quantity": 1},
        {"idProduct": productsSnap[2]['id'], "quantity": 1},
      ],
    };
    final output = await checkout(input);
    expect(output['total'], equals(5330));
  });

  test("Deve criar um pedido com 1 produto calculando o frete", () async {
    final Map<String, dynamic> input = {
      "cpf": "407.302.170-27",
      "items": [
        {"idProduct": productsSnap[0]['id'], "quantity": 3},
      ],
      "from": "22060030",
      "to": "88015600",
    };
    final output = await checkout(input);
    expect(output['freight'], equals(90));
    expect(output['total'], equals(390));
  });
}
