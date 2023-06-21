import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/auth/application/repositories/user_repository.dart';
import 'package:will_store/auth/domain/entities/cart_item.dart';
import 'package:will_store/auth/infra/repositories/user_repository_database.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';
import 'package:will_store/utils/database/firebase_auth_adapter.dart';

import '../../../mocks/user_mock.dart';
import '../utils/user_set_up.dart';

void main() async {
  late MockFirebaseAuth firebaseAuthMock;
  final connection = FakeFirebaseAdapter();
  late FirebaseAuthAdapter firebaseAuth;
  late UserRepository userRepository;
  late GetItemsFromCart getItemsFromCart;
  final List<Map<String, dynamic>> usersSnap = [];
  final userSetUp = UserSetUp(connection);

  setUp(() {
    firebaseAuthMock = MockFirebaseAuth(mockUser: mockUser);
    firebaseAuth = FirebaseAuthAdapter(firebaseAuthMock);
    userRepository = UserRepositoryDatabase(firebaseAuth, connection);
    getItemsFromCart = GetItemsFromCart(userRepository);
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

class GetItemsFromCart {
  final UserRepository _repository;

  GetItemsFromCart(this._repository);

  Future<List<CartItem>> call(String input) async {
    return await _repository.getItemsFromCart(input);
  }
}
