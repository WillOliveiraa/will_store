import 'package:will_store/domain/entities/item_size.dart';

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
      'dimentions':
          dimentions != null ? (dimentions as DimentionsModel).toMap() : null,
    };
  }

  factory ItemSizeModel.fromMap(Map<String, dynamic> map) {
    return ItemSizeModel(
      map['id'] != null ? map['id'] as String : null,
      map['name'] as String,
      map['price'] as num,
      map['stock'] as int,
      map['dimentions'] != null
          ? DimentionsModel.fromMap(map['dimentions'] as Map<String, dynamic>)
          : null,
    );
  }
}
