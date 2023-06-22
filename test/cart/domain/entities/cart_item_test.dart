import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:will_store/cart/domain/entities/cart_item.dart';

import '../../../mocks/cart_items_mock.dart';

void main() {
  final cartMock = cartItemsMock.first;

  test('Deve criar um item do carrinho válido', () {
    final cartItem = CartItem(
      id: cartMock['id'],
      productId: cartMock['productId'],
      quantity: cartMock['quantity'],
      userId: cartMock['userId'],
      sizeName: cartMock['sizeName'],
    );
    expect(cartItem.id, '12');
    expect(cartItem.userId, '1');
    expect(cartItem.productId, '1');
    expect(cartItem.quantity, 2);
    expect(cartItem.sizeName, 'P');
  });

  parameterizedTest(
      'Não deve criar um item do carrinho com id do produto inválido',
      ['', ' '], p1((String value) {
    expect(
        () => CartItem(
              id: cartMock['id'],
              productId: value,
              quantity: cartMock['quantity'],
              userId: cartMock['userId'],
              sizeName: cartMock['sizeName'],
            ),
        throwsA(isA<ArgumentError>().having(
            (error) => error.message, 'message', 'Invalid product id')));
  }));

  parameterizedTest(
      'Não deve criar um item do carrinho com id do usuário inválido',
      ['', ' '], p1((String value) {
    expect(
        () => CartItem(
              id: cartMock['id'],
              productId: cartMock['productId'],
              quantity: cartMock['quantity'],
              userId: value,
              sizeName: cartMock['sizeName'],
            ),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, 'message', 'Invalid user id')));
  }));

  parameterizedTest(
      'Não deve criar um item do carrinho com quantidade inválida', [-1, 0],
      p1((int value) {
    expect(
        () => CartItem(
              id: cartMock['id'],
              productId: cartMock['productId'],
              quantity: value,
              userId: cartMock['userId'],
              sizeName: cartMock['sizeName'],
            ),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, 'message', 'Invalid quantity')));
  }));

  parameterizedTest(
      'Não deve criar um item do carrinho com o tamanho inválido', ['', ' '],
      p1((String value) {
    expect(
        () => CartItem(
              id: cartMock['id'],
              productId: cartMock['productId'],
              quantity: cartMock['quantity'],
              userId: cartMock['userId'],
              sizeName: value,
            ),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, 'message', 'Invalid size name')));
  }));
}
