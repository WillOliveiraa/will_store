import 'package:cloud_firestore/cloud_firestore.dart' as firebase;
import 'package:will_store/utils/database/database_connection.dart';

import '../../application/repositories/order_repository.dart';
import '../../domain/entities/order.dart';
import '../models/order_model.dart';

class OrderRepositoryDatabase implements OrderRepository {
  final DatabaseConnection _connection;
  final _ordersCollection = "orders";

  OrderRepositoryDatabase(this._connection);

  @override
  Future<int> count() async {
    final queryData =
        await _connect.collection(_ordersCollection).count().get();
    return queryData.count;
  }

  @override
  Future<void> save(Order order) async {
    final orderCollection = _connect.collection(_ordersCollection);
    await orderCollection.add((OrderModel(
            cpf: order.cpf.value,
            id: order.id,
            sequence: order.sequence,
            date: order.date))
        .toMap());
  }

  @override
  Future<Map<String, dynamic>> getOrderById(String id) async {
    final orderData = await _getFirestoreRef(id).get();
    if (!orderData.exists) throw ArgumentError("Order not found");
    final order = OrderModel.fromMap(_setId(orderData));
    final output = {
      "code": order.code,
      "total": order.getTotal(),
      "freight": order.freight,
    };
    return output;
  }

  @override
  Future<List<Order>> getOrders() async {
    final orderCollection = _connect.collection(_ordersCollection);
    final ordersData = await orderCollection.get();
    final List<Order> orders = [];
    for (final item in ordersData.docs) {
      final order = OrderModel.fromMap(_setId(item));
      orders.add(order);
    }
    return orders;
  }

  firebase.FirebaseFirestore get _connect =>
      (_connection.connect() as firebase.FirebaseFirestore);

  firebase.DocumentReference _getFirestoreRef(String id) {
    return _connect.doc('$_ordersCollection/$id');
  }

  Map<String, dynamic> _setId(firebase.DocumentSnapshot<Object?> orderData) {
    final data = orderData.data() as Map<String, dynamic>;
    data['id'] = orderData.id;
    return data;
  }
}
