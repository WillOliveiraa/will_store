import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/cart/application/repositories/cart_repository.dart';
import 'package:will_store/cart/application/usecases/add_cart_item.dart';
import 'package:will_store/cart/application/usecases/get_items_from_cart.dart';
import 'package:will_store/cart/infra/models/cart_item_model.dart';
import 'package:will_store/cart/infra/repositories/cart_repository_database.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

import '../../../auth/application/utils/user_set_up.dart';

void main() async {
  final connection = FakeFirebaseAdapter();
  late CartRepository cartRepository;
  late AddCartItem addCartItem;
  late GetItemsFromCart getItemsFromCart;
  final List<Map<String, dynamic>> usersSnap = [];
  final userSetUp = UserSetUp(connection);

  setUp(() {
    cartRepository = CartRepositoryDatabase(connection);
    addCartItem = AddCartItem(cartRepository);
    getItemsFromCart = GetItemsFromCart(cartRepository);
  });

  setUpAll(() async {
    usersSnap.addAll(await userSetUp.users());
  });

  test('Deve adiciona um item do carrinho', () async {
    final userId = usersSnap.first['id'];
    final input = {
      "id": "14",
      "productId": "5",
      "userId": "1",
      "quantity": 10,
      "sizeName": "G"
    };
    final cartItem = CartItemModel.fromMap(input);
    await addCartItem(cartItem, userId);
    final output = await getItemsFromCart(userId);
    expect(output.length, 3);
    expect(output.last.quantity, 10);
    expect(output.last.productId, '5');
    expect(output.last.sizeName, 'G');
  });
}
