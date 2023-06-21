import 'package:cloud_firestore/cloud_firestore.dart' as firebase;
import 'package:will_store/utils/constant.dart';

import '../../../utils/database/database_connection.dart';
import '../../application/repositories/cart_repository.dart';
import '../../domain/entities/cart_item.dart';
import '../models/cart_item_model.dart';

class CartRepositoryDatabase implements CartRepository {
  final DatabaseConnection _connection;

  CartRepositoryDatabase(this._connection);

  @override
  Future<List<CartItem>> getItemsFromCart(String userId) async {
    final snapsCarts = await _cartReference(userId).get();
    final List<CartItemModel> cartItems = [];
    for (final item in snapsCarts.docs) {
      final cartItem = CartItemModel.fromMap(_setId(item));
      cartItems.add(cartItem);
    }
    return cartItems;
  }

  @override
  Future<void> updateCartItem(CartItem cartItem, String userId) async {
    await _cartReference(userId)
        .doc(cartItem.id)
        .update((cartItem as CartItemModel).toMap());
  }

  firebase.FirebaseFirestore get _connect =>
      (_connection.connect() as firebase.FirebaseFirestore);

  firebase.DocumentReference _getFirestoreRef(String id) {
    return _connect.doc('$usersCollection/$id');
  }

  firebase.CollectionReference _cartReference(String userId) {
    return _getFirestoreRef(userId).collection(cartItemCollection);
  }

  Map<String, dynamic> _setId(firebase.DocumentSnapshot<Object?> userData) {
    final data = userData.data() as Map<String, dynamic>;
    data['id'] = userData.id;
    return data;
  }
}
