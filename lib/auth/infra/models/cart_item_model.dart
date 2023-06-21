import '../../domain/entities/cart_item.dart';

class CartItemModel extends CartItem {
  CartItemModel(super.id, super.productId, super.quantity, super.size);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'sizeName': size,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      map['id'] != null ? map['id'] as String : null,
      map['productId'] as String,
      map['quantity'] as int,
      map['sizeName'] as String,
    );
  }
}
