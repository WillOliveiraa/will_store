import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

import '../../domain/entities/order.dart';
import 'order_item_model.dart';

class OrderModel extends Order {
  OrderModel({
    required super.cpf,
    super.id,
    super.sequence,
    super.date,
    required super.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cpf': cpf.value,
      'items': items
          .map((e) =>
              OrderItemModel(e.productId, e.price, e.quantity, e.id).toMap())
          .toList(),
      'sequence': sequence,
      'date': date.millisecondsSinceEpoch,
      'code': code,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] != null ? map['id'] as String : null,
      cpf: map['cpf'] as String,
      sequence: map['sequence'] as int,
      date: (map['date'] as firestore.Timestamp).toDate(),
      userId: map['userId'] as String,
    );
  }
}
