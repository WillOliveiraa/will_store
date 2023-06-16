import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:will_store/auth/application/models/login_input.dart';
import 'package:will_store/auth/application/repositories/user_repository.dart';
import 'package:will_store/auth/application/usecases/login.dart';
import 'package:will_store/auth/infra/repositories/user_repository_database.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';
import 'package:will_store/utils/database/firebase_auth_adapter.dart';

import '../../../mocks/user_mock.dart';
import '../utils/user_set_up.dart';

class FirebaseAuthAdapterMock extends Mock implements FirebaseAuthAdapter {
  final MockFirebaseAuth mockAuth;

  FirebaseAuthAdapterMock(this.mockAuth);
}

void main() {
  late MockFirebaseAuth firebaseAuthMock;
  final connection = FakeFirebaseAdapter();
  late FirebaseAuthAdapter firebaseAuth;
  late UserRepository userRepository;
  late Login login;
  final input = LoginInput(mockUser.email!, '123123');
  final List<Map<String, dynamic>> usersSnap = [];
  final userSetUp = UserSetUp(connection);

  setUp(() {
    firebaseAuthMock = MockFirebaseAuth(mockUser: mockUser);
    firebaseAuth = FirebaseAuthAdapter(firebaseAuthMock);
    userRepository = UserRepositoryDatabase(firebaseAuth, connection);
    login = Login(userRepository);
  });

  setUpAll(() async {
    usersSnap.addAll(await userSetUp.users());
  });

  test('Deve fazer o login', () async {
    final mockUser = MockUser(
      uid: usersSnap.first['id'],
      email: 'will@teste.com',
      displayName: 'Willian Oliveira',
    );
    firebaseAuthMock = MockFirebaseAuth(mockUser: mockUser);
    firebaseAuth = FirebaseAuthAdapter(firebaseAuthMock);
    userRepository = UserRepositoryDatabase(firebaseAuth, connection);
    login = Login(userRepository);
    final output = await login(input);
    expect(output.id, equals(mockUser.uid));
    expect(output.email.value, equals(usersSnap.first['email']));
  });

  test('Deve retornar um erro caso as credenciais estejam inválidas', () {
    final firebaseAuthMock = FirebaseAuthAdapterMock(
        MockFirebaseAuth(mockUser: mockUser, signedIn: true));
    userRepository = UserRepositoryDatabase(firebaseAuthMock, connection);
    when(() => (firebaseAuthMock.connect() as MockFirebaseAuth)
            .signInWithEmailAndPassword(
                email: "tadas@gmail.com", password: "123456"))
        .thenThrow(ArgumentError('Seu e-mail é inválido.'));
    login = Login(userRepository);
    expect(
        () async => await login(input),
        throwsA(isA<ArgumentError>().having(
            (error) => error.message, 'message', 'Seu e-mail é inválido.')));
  });
}
