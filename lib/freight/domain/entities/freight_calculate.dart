import 'dart:math';

import '../../application/models/calculate_freight_input.dart';
import 'distance_calculator.dart';

class FreightCalculate {
  static num calculate(CalculateFreightInput input) {
    num freight = 0;
    num distance = 1000;
    if (input.from != null && input.to != null) {
      distance =
          DistanceCalculator.calculate(input.from!.coord, input.to!.coord);
    }
    if (input.items.isEmpty) throw ArgumentError("Invalid items");
    for (final item in input.items) {
      final itemFreight = _calculateFreight(distance, item.width, item.height,
          item.length, item.weight, item.quantity);
      freight += itemFreight;
    }
    return num.parse(freight.toStringAsFixed(2));
  }

  static num _calculateFreight(
      num distance, num width, num height, num length, num weight,
      [int quantity = 1]) {
    final volume = width / 100 * height / 100 * length / 100;
    final density = weight / volume;
    final itemFreight = distance * volume * (density / 100);
    return max(itemFreight, 10) * quantity;
  }
}
