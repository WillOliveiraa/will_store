import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/cart/application/repositories/cart_repository.dart';
import 'package:will_store/cart/application/usecases/get_items_from_cart.dart';
import 'package:will_store/cart/infra/repositories/cart_repository_database.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

import '../../../auth/application/utils/user_set_up.dart';

void main() async {
  final connection = FakeFirebaseAdapter();
  late CartRepository cartRepository;
  late GetItemsFromCart getItemsFromCart;
  final List<Map<String, dynamic>> usersSnap = [];
  final userSetUp = UserSetUp(connection);

  setUp(() {
    cartRepository = CartRepositoryDatabase(connection);
    getItemsFromCart = GetItemsFromCart(cartRepository);
  });

  setUpAll(() async {
    usersSnap.addAll(await userSetUp.users());
  });

  test('Deve buscar todos os itens do carrinho do usuário', () async {
    final input = usersSnap.first['id'];
    final output = await getItemsFromCart(input);
    expect(output.first.quantity, 2);
    expect(output.first.productId, '1');
    expect(output.first.size, 'P');
  });
}
