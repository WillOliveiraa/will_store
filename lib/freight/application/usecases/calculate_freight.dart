import 'package:will_store/freight/application/repositories/zip_code_repository.dart';
import 'package:will_store/freight/domain/entities/freight_calculate.dart';

import '../../domain/entities/distance_calculator.dart';
import '../models/calculate_freight_input.dart';

class CalculateFreight {
  final ZipCodeRepository _repository;

  CalculateFreight(this._repository);

  Future<Map<String, dynamic>> call(CalculateFreightInput input) async {
    final Map<String, dynamic> output = {"freight": 0};
    num distance = 1000;
    if (input.from != null && input.to != null) {
      final from = await _repository.getZipCode(input.from!);
      final to = await _repository.getZipCode(input.to!);
      if (from != null && to != null) {
        distance = DistanceCalculator.calculate(from.coord, to.coord);
      }
    }
    if (input.items.isEmpty) throw ArgumentError("Invalid items");
    for (final item in input.items) {
      final itemFreight = FreightCalculate.calculate(distance, item.width,
          item.height, item.length, item.weight, item.quantity);
      output['freight'] += itemFreight;
    }
    return output;
  }
}
