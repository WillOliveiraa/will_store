import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/auth/application/repositories/user_repository.dart';
import 'package:will_store/auth/application/usecases/get_user.dart';
import 'package:will_store/auth/infra/repositories/user_repository_database.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';
import 'package:will_store/utils/database/firebase_auth_adapter.dart';

import '../../../mocks/user_mock.dart';
import '../utils/user_set_up.dart';

void main() {
  late MockFirebaseAuth firebaseAuthMock;
  final connection = FakeFirebaseAdapter();
  late FirebaseAuthAdapter firebaseAuth;
  late UserRepository userRepository;
  late GetUser getUser;
  final List<Map<String, dynamic>> usersSnap = [];
  final userSetUp = UserSetUp(connection);

  setUp(() {
    firebaseAuthMock = MockFirebaseAuth(mockUser: mockUser);
    firebaseAuth = FirebaseAuthAdapter(firebaseAuthMock);
    userRepository = UserRepositoryDatabase(firebaseAuth, connection);
    getUser = GetUser(userRepository);
  });

  setUpAll(() async {
    usersSnap.addAll(await userSetUp.users());
  });

  test('Deve buscar um usuário pelo id', () async {
    final mockUser = MockUser(
      isAnonymous: false,
      uid: usersSnap.first['id'],
      email: 'will@teste.com',
      displayName: 'Willian Oliveira',
    );
    firebaseAuthMock = MockFirebaseAuth(mockUser: mockUser);
    firebaseAuth = FirebaseAuthAdapter(firebaseAuthMock);
    userRepository = UserRepositoryDatabase(firebaseAuth, connection);
    getUser = GetUser(userRepository);
    final input = usersSnap.first['id'];
    await firebaseAuthMock.signInWithEmailAndPassword(
        email: mockUser.email!, password: '123123');
    final output = await getUser(input);
    expect(output.id, equals(usersMock.first['id']));
    expect(output.email.value, equals(usersMock.first['email']));
    expect(output.firstName, equals(usersMock.first['firstName']));
  });

  test('Deve retornar um erro quando não encontrar um usúario', () {
    const userId = '1';
    expect(
        () async => await getUser(userId),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, 'message', 'User not found')));
  });
}
