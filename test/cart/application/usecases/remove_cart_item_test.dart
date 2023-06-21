import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/cart/application/repositories/cart_repository.dart';
import 'package:will_store/cart/application/usecases/get_items_from_cart.dart';
import 'package:will_store/cart/application/usecases/remove_cart_item.dart';
import 'package:will_store/cart/infra/repositories/cart_repository_database.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

import '../../../auth/application/utils/user_set_up.dart';

void main() async {
  final connection = FakeFirebaseAdapter();
  late CartRepository cartRepository;
  late RemoveCartItem removeCartItem;
  late GetItemsFromCart getItemsFromCart;
  final List<Map<String, dynamic>> usersSnap = [];
  final userSetUp = UserSetUp(connection);

  setUp(() {
    cartRepository = CartRepositoryDatabase(connection);
    removeCartItem = RemoveCartItem(cartRepository);
    getItemsFromCart = GetItemsFromCart(cartRepository);
  });

  setUpAll(() async {
    usersSnap.addAll(await userSetUp.users());
  });

  test('Deve atualizar um item do carrinho', () async {
    final userId = usersSnap.first['id'];
    final cartItemId = usersSnap.first['cartItems'].first['id'];
    await removeCartItem(cartItemId, userId);
    final output = await getItemsFromCart(userId);
    expect(output.length, 1);
  });
}
