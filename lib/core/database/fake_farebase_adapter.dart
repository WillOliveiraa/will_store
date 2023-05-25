import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:will_store/core/database/database_connection.dart';

class FakeFirebaseAdapter implements DatabaseConnection {
  FakeFirebaseFirestore firestore;

  FakeFirebaseAdapter() : firestore = FakeFirebaseFirestore();

  @override
  Object? connect() {
    return firestore;
  }
}
