import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/domain/entities/item_size.dart';

void main() {
  test('Deve criar um item de size', () {
    final itemSize = ItemSize("1", "P", 19, 5, null);
    expect(itemSize.id, equals('1'));
    expect(itemSize.name, equals('P'));
  });

  test('Não deve criar um item de size com nome inválido', () {
    expect(
        () => ItemSize("1", "", 19, 5, null),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, 'message', "Invalid name")));
  });

  test('Não deve criar um item de size com preço inválido', () {
    expect(
        () => ItemSize("1", "P", 0, 5, null),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, 'message', "Invalid price")));
  });

  test('Não deve criar um item de size com estoque inválido', () {
    expect(
        () => ItemSize("1", "P", 20, 0, null),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, 'message', "Invalid stock")));
  });
}