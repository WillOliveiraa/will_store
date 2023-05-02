import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/domain/entities/dimentions.dart';

void main() {
  test('Não deve criar uma dimenção "width" negativa', () {
    expect(
        () => Dimentions("1", -1, 10, 10, 10),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, 'message', "Invalid width")));
  });

  test('Não deve criar uma dimenção "height" negativa', () {
    expect(
        () => Dimentions("1", 10, -10, 10, 10),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, 'message', "Invalid height")));
  });

  test('Não deve criar uma dimenção "length" negativa', () {
    expect(
        () => Dimentions("1", 10, 10, -10, 10),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, 'message', "Invalid length")));
  });

  test('Não deve criar uma dimenção "weight" negativa', () {
    expect(
        () => Dimentions("1", 10, 10, 10, -10),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, 'message', "Invalid weight")));
  });

  test('Deve criar uma nova dimenção', () {
    final dimentions = Dimentions("1", 10, 20, 15, 100);
    expect(dimentions.id, equals("1"));
    expect(dimentions.width, equals(10));
  });
}
