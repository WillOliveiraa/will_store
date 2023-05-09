import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:will_store/core/database/connection.dart';

class FakeFirebaseAdapter implements Connection {
  FakeFirebaseFirestore firestore;

  FakeFirebaseAdapter() : firestore = FakeFirebaseFirestore();

  @override
  Object? connect() {
    return firestore;
  }
}
