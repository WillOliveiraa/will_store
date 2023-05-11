import 'calculate_freight_item.dart';

class CalculateFreightInput {
  final List<CalculateFreightItem> items;
  final String? from;
  final String? to;

  CalculateFreightInput(this.items, this.from, this.to);
}
