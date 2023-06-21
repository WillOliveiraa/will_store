import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/cart/application/repositories/cart_repository.dart';
import 'package:will_store/cart/application/usecases/get_items_from_cart.dart';
import 'package:will_store/cart/application/usecases/update_cart_item.dart';
import 'package:will_store/cart/infra/models/cart_item_model.dart';
import 'package:will_store/cart/infra/repositories/cart_repository_database.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

import '../../../auth/application/utils/user_set_up.dart';

void main() async {
  final connection = FakeFirebaseAdapter();
  late CartRepository cartRepository;
  late UpdateCartItem updateCartItem;
  late GetItemsFromCart getItemsFromCart;
  final List<Map<String, dynamic>> usersSnap = [];
  final userSetUp = UserSetUp(connection);

  setUp(() {
    cartRepository = CartRepositoryDatabase(connection);
    updateCartItem = UpdateCartItem(cartRepository);
    getItemsFromCart = GetItemsFromCart(cartRepository);
  });

  setUpAll(() async {
    usersSnap.addAll(await userSetUp.users());
  });

  test('Deve atualizar um item do carrinho', () async {
    final userId = usersSnap.first['id'];
    final input = usersSnap.first['cartItems'].first;
    input['quantity'] = 5;
    input['sizeName'] = 'GG';
    final cartItem = CartItemModel.fromMap(input);
    await updateCartItem(cartItem, userId);
    final output = await getItemsFromCart(userId);
    expect(output.first.quantity, 5);
    expect(output.first.productId, '1');
    expect(output.first.size, 'GG');
  });
}
