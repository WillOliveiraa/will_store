import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/freight/domain/entities/coord.dart';
import 'package:will_store/freight/domain/entities/distance_calculator.dart';

void main() {
  test('Deve calcular a distancia entre dois CEPs', () {
    final from = Coord(-27.5945, -48.5477);
    final to = Coord(-22.9129, -43.2003);
    final distance = DistanceCalculator.calculate(from, to);
    expect(distance, equals(748.22177800816310));
  });
}
