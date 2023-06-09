import 'package:cloud_firestore/cloud_firestore.dart' as firebase;
// ignore: library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:will_store/utils/constant.dart';

import '../../../utils/database/auth_connection.dart';
import '../../../utils/database/database_connection.dart';
import '../../../utils/helpers/firebase_errors.dart';
import '../../application/inputs/login_input.dart';
import '../../application/repositories/user_repository.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

class UserRepositoryDatabase implements UserRepository {
  final AuthConnection _auth;
  final DatabaseConnection _connection;

  UserRepositoryDatabase(this._auth, this._connection);

  @override
  Future<void> save(User user) async {
    final reference = _getFirestoreRef(user.id!);
    reference.set((user as UserModel).toMap());
  }

  @override
  Future<Map<String, dynamic>> signUp(User user) async {
    try {
      final userCredential = await _connectAuth.createUserWithEmailAndPassword(
          email: user.email.value, password: user.password!.value);
      return {"userId": userCredential.user!.uid};
    } on firebase.FirebaseException catch (e) {
      throw ArgumentError(getErrorString(e.code));
    }
  }

  @override
  Future<String> login(LoginInput input) async {
    try {
      final userCredential = await _connectAuth.signInWithEmailAndPassword(
          email: input.email, password: input.password);
      final user = userCredential.user;
      return user!.uid;
    } on firebaseAuth.FirebaseAuthException catch (e) {
      throw ArgumentError(getErrorString(e.code));
    }
  }

  @override
  Future<User> getCurrentUser(String userId) async {
    final currentUser = _connectAuth.currentUser;
    if (currentUser == null || currentUser.uid != userId) {
      throw ArgumentError('User not found');
    }
    final userData = await _getFirestoreRef(userId).get();
    return UserModel.fromMap(_setId(userData));
  }

  MockFirebaseAuth get _connectAuth => (_auth.connect() as MockFirebaseAuth);

  firebase.FirebaseFirestore get _connect =>
      (_connection.connect() as firebase.FirebaseFirestore);

  firebase.DocumentReference _getFirestoreRef(String id) {
    return _connect.doc('$usersCollection/$id');
  }

  Map<String, dynamic> _setId(firebase.DocumentSnapshot<Object?> userData) {
    final data = userData.data() as Map<String, dynamic>;
    data['id'] = userData.id;
    return data;
  }
}
