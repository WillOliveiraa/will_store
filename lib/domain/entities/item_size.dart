import 'package:will_store/domain/entities/dimentions.dart';

class ItemSize {
  final String? _id;
  final String _name;
  final num _price;
  final int _stock;
  final Dimentions? _dimentions;

  ItemSize(
    this._id,
    this._name,
    this._price,
    this._stock,
    this._dimentions,
  ) {
    if (_name.isEmpty) throw ArgumentError("Invalid name");
    if (_price.isNegative || _price == 0.0) {
      throw ArgumentError("Invalid price");
    }
    if (_stock <= 0) throw ArgumentError("Invalid stock");
  }

  String? get id => _id;

  String get name => _name;

  get price => _price;

  get stock => _stock;

  get dimentions => _dimentions;
}
