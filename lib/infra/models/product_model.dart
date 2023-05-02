import 'package:will_store/domain/entities/product.dart';
import 'package:will_store/infra/models/item_size_model.dart';

class ProductModel extends Product {
  ProductModel(
      super.id, super.name, super.description, super.images, super.itemSize);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'images': images,
      'itemSize': itemSize.map((x) => (x as ItemSizeModel).toMap()).toList(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      map['id'] != null ? map['id'] as String : null,
      map['name'] as String,
      map['description'] as String,
      map['images'] != null ? List<String>.from((map['images'])) : null,
      List.from(map['itemSize']).map((x) => ItemSizeModel.fromMap(x)).toList(),
    );
  }
}
