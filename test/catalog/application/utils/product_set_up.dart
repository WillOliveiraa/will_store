import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:will_store/utils/constant.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

import '../../../mocks/products_mock.dart';

class ProductSetUp {
  final FakeFirebaseAdapter connection;
  late final CollectionReference<Map<String, dynamic>> _productCollection;

  ProductSetUp(this.connection) {
    _productCollection = connection.firestore.collection(productsCollection);
  }

  Future<List<Map<String, dynamic>>> products() async {
    final List<Map<String, dynamic>> productSnap = [];
    for (final itemMock in productsMock) {
      final itemSnapshot = await _productCollection.add(itemMock);
      itemMock['id'] = itemSnapshot.id;
      productSnap.add(itemMock);
    }
    return productSnap;
  }
}
