import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

import '../../domain/entities/order.dart';
import 'order_item_model.dart';

class OrderModel extends Order {
  OrderModel({required super.cpf, super.id, super.sequence, super.date});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cpf': cpf.value,
      'items': items
          .map((e) => OrderItemModel(e.productId, e.price, e.quantity).toMap())
          .toList(),
      'sequence': sequence,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] != null ? map['id'] as String : null,
      cpf: map['cpf'] as String,
      sequence: map['sequence'] as int,
      date: (map['date'] as firestore.Timestamp).toDate(),
    );
  }
}