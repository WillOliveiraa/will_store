import 'package:will_store/domain/entities/item_size.dart';

class Product {
  final String? _id;
  final String _name;
  final String _description;
  final List<String>? _images;
  final List<ItemSize> _itemSize;

  Product(
    this._id,
    this._name,
    this._description,
    this._images,
    this._itemSize,
  ) {
    if (_name.trim().isEmpty || _name.length < 3) {
      throw ArgumentError("Invalid name");
    }
    if (_description.trim().isEmpty || _description.length < 5) {
      throw ArgumentError("Invalid description");
    }
  }

  String? get id => _id;

  String get name => _name;

  String get description => _description;

  List<String>? get images => _images;

  List<ItemSize> get itemSize => _itemSize;

  num getVolume() {
    final dimentions = _itemSize.first.dimentions;
    return (dimentions.width / 100) *
        (dimentions.height / 100) *
        (dimentions.length / 100);
  }
}
