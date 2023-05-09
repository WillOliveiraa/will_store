import '../../domain/entities/order_item.dart';

class OrderItemModel extends OrderItem {
  OrderItemModel(super.productId, super.price, super.quantity);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'price': price,
      'quantity': quantity,
    };
  }
}
