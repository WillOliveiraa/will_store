import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:will_store/auth/application/models/sign_up_input.dart';
import 'package:will_store/auth/application/usecases/get_user.dart';
import 'package:will_store/auth/application/usecases/sign_up.dart';
import 'package:will_store/auth/infra/repositories/user_repository_database.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';
import 'package:will_store/utils/database/firebase_auth_adapter.dart';

class FirebaseAuthAdapterMock extends Mock implements FirebaseAuthAdapter {
  final MockFirebaseAuth mockAuth;

  FirebaseAuthAdapterMock(this.mockAuth);
}

void main() {
  final mockUser = MockUser(
    isAnonymous: false,
    uid: '1001',
    email: 'will@teste.com',
    displayName: 'Willian Oliveira',
  );
  late FirebaseAuthAdapter firebaseAuth;
  late UserRepositoryDatabase userRepository;
  late SignUp signUp;
  final connection = FakeFirebaseAdapter();
  final input = SignUpInput(mockUser.displayName!, mockUser.email!, '123123');
  final mockFirebaseAuth = MockFirebaseAuth(mockUser: mockUser, signedIn: true);

  setUp(() {
    firebaseAuth = FirebaseAuthAdapter(mockFirebaseAuth);
    userRepository = UserRepositoryDatabase(firebaseAuth, connection);
    signUp = SignUp(userRepository);
  });

  test('Deve cadastrar um novo usuário', () async {
    final outputSignIn = await signUp(input);
    final userId = outputSignIn['userId'];
    final getUser = GetUser(userRepository);
    final output = await getUser(userId);
    expect(output.id, equals(userId));
    expect(output.username, equals(input.username));
    expect(output.email, equals(input.email));
  });

  test('Não deve cadastrar um novo usuário com e-mail duplicado', () {
    final firebaseAuthMock = FirebaseAuthAdapterMock(
        MockFirebaseAuth(mockUser: mockUser, signedIn: true));
    userRepository = UserRepositoryDatabase(firebaseAuthMock, connection);
    when(() => (firebaseAuthMock.connect() as MockFirebaseAuth)
        .createUserWithEmailAndPassword(
            email: "tadas@gmail.com", password: "123456")).thenThrow(
        ArgumentError('E-mail já está sendo utilizado em outra conta.'));
    final signUp = SignUp(userRepository);
    expect(
        () async => await signUp(input),
        throwsA(isA<ArgumentError>().having((error) => error.message, 'message',
            'E-mail já está sendo utilizado em outra conta.')));
  });
}
