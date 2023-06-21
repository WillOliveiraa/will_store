import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:will_store/utils/constant.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

import '../../../mocks/cart_items_mock.dart';
import '../../../mocks/user_mock.dart';

class UserSetUp {
  final FakeFirebaseAdapter connection;
  late final CollectionReference<Map<String, dynamic>> _usersCollection;

  UserSetUp(this.connection) {
    _usersCollection = connection.firestore.collection('users');
  }

  Future<List<Map<String, dynamic>>> users() async {
    final List<Map<String, dynamic>> usersSnap = [];
    for (final itemMock in usersMock) {
      final itemSnapshot = await _usersCollection.add(itemMock);
      itemMock['id'] = itemSnapshot.id;
      usersSnap.add(itemMock);
      if (usersSnap.length == 1) {
        final List<Map<String, dynamic>> cartItemsSnaps = [];
        final cartItemColl = _usersCollection
            .doc(usersSnap.first['id'])
            .collection(cartItemCollection);
        for (final item in cartItemsMock) {
          final cartItemSnap = await cartItemColl.add(item);
          item['id'] = cartItemSnap.id;
          cartItemsSnaps.add(item);
        }
        usersSnap.first['cartItems'] = cartItemsSnaps;
      }
    }
    return usersSnap;
  }
}
