import '../../domain/entities/zip_code.dart';
import 'calculate_freight_item.dart';

class CalculateFreightInput {
  final List<CalculateFreightItem> items;
  ZipCode? _from;
  ZipCode? _to;

  CalculateFreightInput(this.items, this._from, this._to);

  // ignore: unnecessary_getters_setters
  ZipCode? get from => _from;

  set from(ZipCode? value) => _from = value;

  set to(ZipCode? value) => _to = value;

  // ignore: unnecessary_getters_setters
  ZipCode? get to => _to;
}
