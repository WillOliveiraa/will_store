import '../inputs/calculate_freight_input.dart';

abstract class FreightGateway {
  Future<Map<String, dynamic>> calculateFreight(CalculateFreightInput input);
}
