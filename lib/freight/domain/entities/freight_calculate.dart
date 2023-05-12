import 'dart:math';

class FreightCalculate {
  static num calculate(
      num distance, num width, num height, num length, num weight,
      [int quantity = 1]) {
    final volume = width / 100 * height / 100 * length / 100;
    final density = weight / volume;
    final itemFreight = distance * volume * (density / 100);
    return max(itemFreight, 10) * quantity;
  }
}
