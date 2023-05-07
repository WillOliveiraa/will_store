import 'package:will_store/domain/entities/dimentions.dart';

class ItemSize {
  final String? id;
  final String name;
  final num price;
  final int stock;
  final Dimentions dimentions;

  ItemSize(
    this.id,
    this.name,
    this.price,
    this.stock,
    this.dimentions,
  ) {
    if (name.isEmpty) throw ArgumentError("Invalid name");
    if (price.isNegative || price == 0.0) {
      throw ArgumentError("Invalid price");
    }
    if (stock <= 0) throw ArgumentError("Invalid stock");
  }
}
