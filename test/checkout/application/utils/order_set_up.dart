import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

import '../../../mocks/items_order_mock.dart';
import '../../../mocks/orders_mock.dart';

class OrderSetUp {
  final FakeFirebaseAdapter connection;
  late final CollectionReference<Map<String, dynamic>> _itemsCollection;
  late final CollectionReference<Map<String, dynamic>> _ordersCollection;

  OrderSetUp(this.connection) {
    _itemsCollection = connection.firestore.collection('itemsOrders');
    _ordersCollection = connection.firestore.collection('orders');
  }

  Future<List<Map<String, dynamic>>> itemsOrder() async {
    final List<Map<String, dynamic>> itemsOrderSnap = [];
    for (int j = 0; j < itemsOrderMock.length; j++) {
      final itemMock = itemsOrderMock[j];
      final itemSnapshot = await _itemsCollection.add(itemMock);
      itemMock['id'] = itemSnapshot.id;
      itemsOrderSnap.add(itemMock);
    }
    return itemsOrderSnap;
  }

  Future<List<Map<String, dynamic>>> orders() async {
    final List<Map<String, dynamic>> ordersSnap = [];
    for (int i = 0; i < ordersMock.length; i++) {
      final orderMock = ordersMock[i];
      final orderSnapshot = await _ordersCollection.add(ordersMock[i]);
      for (final item in itemsOrderMock) {
        if (item['orderId'] == orderMock['id']) {
          item['orderId'] = orderSnapshot.id;
          await _itemsCollection.doc(item['id'].toString()).update(item);
        }
      }
      orderMock['id'] = orderSnapshot.id;
      ordersSnap.add(orderMock);
    }
    return ordersSnap;
  }

  Future<void> sequences() async {
    await connection.firestore.doc('aux/orderSequence').set({'current': 2});
  }
}
