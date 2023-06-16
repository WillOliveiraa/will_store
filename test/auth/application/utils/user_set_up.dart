import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

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
    }
    return usersSnap;
  }
}
