import '../../domain/entities/cart_item.dart';

class CartItemModel extends CartItem {
  CartItemModel({
    super.id,
    required super.productId,
    required super.userId,
    required super.quantity,
    required super.sizeName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'sizeName': sizeName,
      'userId': userId,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] != null ? map['id'] as String : null,
      productId: map['productId'] as String,
      userId: map['userId'] as String,
      quantity: map['quantity'] as int,
      sizeName: map['sizeName'] as String,
    );
  }
}
