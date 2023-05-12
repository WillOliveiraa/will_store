class Dimentions {
  final String? id;
  final num width;
  final num height;
  final num length;
  final num weight;

  Dimentions(this.id, this.width, this.height, this.length, this.weight) {
    if (width.isNegative) throw ArgumentError("Invalid width");
    if (height.isNegative) throw ArgumentError("Invalid height");
    if (length.isNegative) throw ArgumentError("Invalid length");
    if (weight.isNegative) throw ArgumentError("Invalid weight");
  }

  num getVolume() {
    return (width / 100) * (height / 100) * (length / 100);
  }

  num getDensity() {
    return getVolume() / weight;
  }
}
