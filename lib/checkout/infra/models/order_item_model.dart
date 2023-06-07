import '../../domain/entities/order_item.dart';

class OrderItemModel extends OrderItem {
  OrderItemModel(super.productId, super.price, super.quantity, super.id);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'price': price,
      'quantity': quantity,
    };
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(map['productId'] as String, map['price'] as num,
        map['quantity'] as int, map['id'] as String);
  }
}
