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

  get id => _id;

  get name => _name;

  get description => _description;

  get images => _images;

  get itemSize => _itemSize;

  @override
  String toString() {
    return 'Product(_id: $_id, _name: $_name, _description: $_description, _images: $_images, _itemSize: $_itemSize)';
  }
}
