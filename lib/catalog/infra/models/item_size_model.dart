import 'package:will_store/catalog/domain/entities/item_size.dart';

import 'dimentions_model.dart';

class ItemSizeModel extends ItemSize {
  ItemSizeModel(
      super.id, super.name, super.price, super.stock, super.dimentions);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'stock': stock,
      'dimentions': (dimentions as DimentionsModel).toMap(),
    };
  }

  factory ItemSizeModel.fromMap(Map<String, dynamic> map) {
    return ItemSizeModel(
      map['id'] != null ? map['id'] as String : null,
      map['name'] as String,
      map['price'] as num,
      map['stock'] as int,
      DimentionsModel.fromMap(map['dimentions'] as Map<String, dynamic>),
    );
  }
}
