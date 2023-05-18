import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/freight/application/models/calculate_freight_input.dart';
import 'package:will_store/freight/application/models/calculate_freight_item.dart';
import 'package:will_store/freight/domain/entities/freight_calculate.dart';

void main() {
  test('Deve calcular o frete do produto de um item com quantidade 1', () {
    final input = CalculateFreightInput(
        [CalculateFreightItem(100, 30, 10, 3, 1)], null, null);
    final freight = FreightCalculate.calculate(input);
    expect(freight, equals(30));
  });

  test('Deve calcular o frete do produto com quantidade 3', () {
    final input = CalculateFreightInput(
        [CalculateFreightItem(100, 30, 10, 3, 3)], null, null);
    final freight = FreightCalculate.calculate(input);
    expect(freight, equals(90));
  });

  test('Deve calcular o frete do produto com preço mínimo', () {
    final input = CalculateFreightInput(
        [CalculateFreightItem(100, 30, 10, 0.9, 1)], null, null);
    final freight = FreightCalculate.calculate(input);
    expect(freight, equals(10));
  });
}
