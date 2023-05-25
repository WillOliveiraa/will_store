// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:will_store/core/database/database_connection.dart';

class FirebaseAdapter implements DatabaseConnection {
  FirebaseFirestore firestore;

  FirebaseAdapter() : firestore = FirebaseFirestore.instance;

  @override
  Object? connect() {
    return firestore;
  }
}
