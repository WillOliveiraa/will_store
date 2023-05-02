class Dimentions {
  final String? _id;
  final num _width;
  final num _height;
  final num _length;
  final num _weight;

  Dimentions(this._id, this._width, this._height, this._length, this._weight) {
    if (_width.isNegative) throw ArgumentError("Invalid width");
    if (_height.isNegative) throw ArgumentError("Invalid height");
    if (_length.isNegative) throw ArgumentError("Invalid length");
    if (_weight.isNegative) throw ArgumentError("Invalid weight");
  }

  get id => _id;

  get width => _width;

  get height => _height;

  get length => _length;

  get weight => _weight;
}
