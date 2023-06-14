import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

import 'auth_connection.dart';

class FirebaseAuthAdapter implements AuthConnection {
  late MockFirebaseAuth auth;

  FirebaseAuthAdapter(this.auth);

  @override
  Object? connect() {
    return auth;
  }
}
