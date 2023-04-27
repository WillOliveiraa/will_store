class Product {
  final String? _id;
  final String _name;
  final String _description;
  final List<String>? _images;
  final String _size;

  Product(this._id, this._name, this._description, this._images, this._size) {
    if (_name.trim().isEmpty || _name.length < 3) {
      throw ArgumentError("Invalid name");
    }
    if (_description.trim().isEmpty || _description.length < 5) {
      throw ArgumentError("Invalid description");
    }
    if (_size.trim().isEmpty) throw ArgumentError("Invalid size");
  }

  get id => _id;

  get name => _name;

  get description => _description;

  get images => _images;

  get size => _size;

  @override
  String toString() {
    return 'Product(_id: $_id, _name: $_name, _description: $_description, _images: $_images, _size: $_size)';
  }
}
