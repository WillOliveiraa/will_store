import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:will_store/catalog/application/repositories/product_repository.dart';
import 'package:will_store/catalog/infra/repositories/product_repository_database.dart';
import 'package:will_store/checkout/application/repositories/coupon_repository.dart';
import 'package:will_store/checkout/application/repositories/order_repository.dart';
import 'package:will_store/checkout/application/usecases/checkout.dart';
import 'package:will_store/checkout/infra/repositories/coupon_repository_database.dart';
import 'package:will_store/checkout/infra/repositories/order_repository_database.dart';
import 'package:will_store/core/database/fake_farebase_adapter.dart';

import '../../../mocks/coupons_mock.dart';
import '../../../mocks/orders_mock.dart';
import '../../../mocks/products_mock.dart';

void main() async {
  final connection = FakeFirebaseAdapter();
  late ProductRepository productRepository;
  late CouponRepository couponRepository;
  late OrderRepository orderRepository;
  late Checkout checkout;
  final List<Map<String, dynamic>> productsSnap = [];
  final List<Map<String, dynamic>> couponsSnap = [];
  final List<Map<String, dynamic>> ordersSnap = [];
  final collection = connection.firestore.collection('products');
  final orderCollection = connection.firestore.collection('orders');

  setUp(() {
    productRepository = ProductRepositoryDatabase(connection);
    couponRepository = CouponRepositoryDatabase(connection);
    orderRepository = OrderRepositoryDatabase(connection);
    checkout = Checkout(productRepository, couponRepository, orderRepository);
  });

  setUpAll(() async {
    for (int i = 0; i < productsMock.length; i++) {
      final snapshot = await collection.add(productsMock[i]);
      final productMock = productsMock[i];
      productMock['id'] = snapshot.id;
      productsSnap.add(productMock);
    }
    final couponCollection = connection.firestore.collection('coupons');
    for (int i = 0; i < couponsMock.length; i++) {
      final snapshot = await couponCollection.add(couponsMock[i]);
      final couponMock = couponsMock[i];
      couponMock['id'] = snapshot.id;
      couponsSnap.add(couponMock);
    }
    for (int i = 0; i < ordersMock.length; i++) {
      final snapshot = await orderCollection.add(ordersMock[i]);
      final orderMock = ordersMock[i];
      orderMock['id'] = snapshot.id;
      ordersSnap.add(orderMock);
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

  test("Deve criar um pedido com 3 produtos e com cupom de desconto", () async {
    final Map<String, dynamic> input = {
      "cpf": "407.302.170-27",
      "items": [
        {"idProduct": productsSnap[0]['id'], "quantity": 1},
        {"idProduct": productsSnap[1]['id'], "quantity": 1},
        {"idProduct": productsSnap[2]['id'], "quantity": 3},
      ],
      "coupon": "VALE20",
    };
    final output = await checkout(input);
    expect(output['total'], equals(4152));
  });

  test("Não deve criar um pedido com o cupom de desconto não encontrado",
      () async {
    final Map<String, dynamic> input = {
      "cpf": "407.302.170-27",
      "items": [
        {"idProduct": productsSnap[0]['id'], "quantity": 1},
      ],
      "coupon": "VALE90",
    };
    expect(
        () async => await checkout(input),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, "message", "Coupon not found")));
  });

  test("Deve criar um pedido com 3 produtos e com cupom de desconto expirado",
      () async {
    final Map<String, dynamic> input = {
      "cpf": "407.302.170-27",
      "items": [
        {"idProduct": productsSnap[0]['id'], "quantity": 3},
        {"idProduct": productsSnap[1]['id'], "quantity": 1},
        {"idProduct": productsSnap[2]['id'], "quantity": 1},
      ],
      "coupon": "VALE10",
    };
    final output = await checkout(input);
    expect(output['total'], equals(5330));
  });

  test("Deve criar um pedido com 3 produto calculando o frete", () async {
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

  test("Deve criar um pedido com 1 produto calculando o frete com valor mínimo",
      () async {
    final Map<String, dynamic> input = {
      "cpf": "407.302.170-27",
      "items": [
        {"idProduct": productsSnap[0]['id'], "quantity": 1},
      ],
      "from": "22060030",
      "to": "88015600",
    };
    final output = await checkout(input);
    expect(output['freight'], equals(10));
    expect(output['total'], equals(110));
  });

  test("Deve criar um pedido e verificar o código de série", () async {
    final Map<String, dynamic> input = {
      "cpf": "407.302.170-27",
      "items": [
        {"idProduct": productsSnap[0]['id'], "quantity": 1},
      ],
    };
    final output = await checkout(input);
    final ordersData = await orderCollection.get();
    final orderData = ordersData.docs.last.data();
    expect(output['total'], equals(100));
    expect(orderData['code'], equals("202300000002"));
  });

  test("Não deve criar um pedido se o produto estiver com dimensão inválida",
      () async {
    final productMock = productsSnap[0];
    productMock['itemSize'][0]['dimentions']['width'] = -1;
    final snapshot = await collection.add(productMock);
    productMock['id'] = snapshot.id;
    productsSnap.add(productMock);
    final Map<String, dynamic> input = {
      "cpf": "407.302.170-27",
      "items": [
        {"idProduct": productsSnap.last['id'], "quantity": 1},
      ],
    };
    expect(
        () async => await checkout(input),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, "message", "Invalid width")));
  });
}
