import 'package:cloud_firestore/cloud_firestore.dart' as firebase;
import 'package:will_store/checkout/infra/models/order_item_model.dart';
import 'package:will_store/utils/constant.dart';
import 'package:will_store/utils/database/database_connection.dart';

import '../../application/repositories/order_repository.dart';
import '../../domain/entities/order.dart';
import '../models/order_model.dart';

class OrderRepositoryDatabase implements OrderRepository {
  final DatabaseConnection _connection;

  OrderRepositoryDatabase(this._connection);

  @override
  Future<int> count() async {
    final queryData = await _orderCollection().count().get();
    return queryData.count;
  }

  @override
  Future<void> save(Order order) async {
    await _orderCollection().add(
      (OrderModel(
        cpf: order.cpf.value,
        id: order.id,
        sequence: order.sequence,
        date: order.date,
        userId: order.userId,
      )).toMap(),
    );
  }

  @override
  Future<Order> getOrderById(String id) async {
    final orderData = await _getFirestoreRef(id).get();
    if (!orderData.exists) throw ArgumentError("Order not found");
    final order = OrderModel.fromMap(_setId(orderData));
    order.items.addAll(await _getItemsOrder(order.id));
    return order;
  }

  @override
  Future<List<Order>> getAllOrders() async {
    final ordersData = await _orderCollection().get();
    final List<Order> orders = [];
    for (final item in ordersData.docs) {
      final order = OrderModel.fromMap(_setId(item));
      order.items.addAll(await _getItemsOrder(order.id));
      orders.add(order);
    }
    return orders;
  }

  @override
  Future<List<OrderModel>> getMyOrders(String userId) async {
    final ordersData =
        await _orderCollection().where('userId', isEqualTo: userId).get();
    final List<OrderModel> orders = await _setOrderList(ordersData.docs);
    return orders;
  }

  Future<List<OrderModel>> _setOrderList(
      List<firebase.QueryDocumentSnapshot<Object?>> ordersData) async {
    final List<OrderModel> orders = [];
    for (final item in ordersData) {
      final order = OrderModel.fromMap(_setId(item));
      order.items.addAll(await _getItemsOrder(order.id));
      orders.add(order);
    }
    return orders;
  }

  Future<List<OrderItemModel>> _getItemsOrder(String? orderId) async {
    List<OrderItemModel> itemsOrder = [];
    final itemCollection = _connect.collection(itemsCollection);
    final itemsData = await itemCollection.get();
    for (final itemOrder in itemsData.docs) {
      if (itemOrder['orderId'] == orderId) {
        final itemOrderIns = OrderItemModel.fromMap(_setId(itemOrder));
        itemsOrder.add(itemOrderIns);
      }
    }
    return itemsOrder;
  }

  firebase.FirebaseFirestore get _connect =>
      (_connection.connect() as firebase.FirebaseFirestore);

  firebase.CollectionReference _orderCollection() {
    return _connect.collection(ordersCollection);
  }

  firebase.DocumentReference _getFirestoreRef(String id) {
    return _orderCollection().doc(id);
  }

  Map<String, dynamic> _setId(firebase.DocumentSnapshot<Object?> orderData) {
    final data = orderData.data() as Map<String, dynamic>;
    data['id'] = orderData.id;
    return data;
  }
}
