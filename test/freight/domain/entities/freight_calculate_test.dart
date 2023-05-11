import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/freight/domain/entities/freight_calculate.dart';

void main() {
  test('Deve calcular o frete do produto de um item com quantidade 1', () {
    final freight = FreightCalculate.calculate(1000, 100, 30, 10, 3);
    expect(freight, equals(30));
  });

  test('Deve calcular o frete do produto com quantidade 3', () {
    final freight = FreightCalculate.calculate(1000, 100, 30, 10, 3, 3);
    expect(freight, equals(90));
  });

  test('Deve calcular o frete do produto com preço mínimo', () {
    final freight = FreightCalculate.calculate(1000, 100, 30, 10, 0.9);
    expect(freight, equals(10));
  });
}
