import 'dart:math';

import 'package:will_store/domain/entities/product.dart';

class FreightCalculate {
  static num calculate(Product product, [int quantity = 1]) {
    final volume = product.getVolume();
    final density = product.itemSize.first.dimentions?.weight / volume;
    final itemFreight = 1000 * volume * (density / 100);
    return max(itemFreight, 10) * quantity;
  }
}
