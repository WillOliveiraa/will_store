import 'package:will_store/catalog/domain/entities/item_size.dart';

class Product {
  final String? id;
  final String name;
  final String description;
  final List<String>? images;
  final List<ItemSize> itemSize;

  Product(
    this.id,
    this.name,
    this.description,
    this.images,
    this.itemSize,
  ) {
    if (name.trim().isEmpty || name.length < 3) {
      throw ArgumentError("Invalid name");
    }
    if (description.trim().isEmpty || description.length < 5) {
      throw ArgumentError("Invalid description");
    }
  }
}
