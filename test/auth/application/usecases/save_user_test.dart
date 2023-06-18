import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/auth/application/repositories/user_repository.dart';
import 'package:will_store/auth/application/usecases/get_user.dart';
import 'package:will_store/auth/application/usecases/save_user.dart';
import 'package:will_store/auth/infra/models/email_model.dart';
import 'package:will_store/auth/infra/models/password_model.dart';
import 'package:will_store/auth/infra/models/user_model.dart';
import 'package:will_store/auth/infra/repositories/user_repository_database.dart';
import 'package:will_store/checkout/infra/models/cpf_model.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';
import 'package:will_store/utils/database/firebase_auth_adapter.dart';

import '../../../mocks/user_mock.dart';
import '../utils/user_set_up.dart';

void main() {
  late MockFirebaseAuth firebaseAuthMock;
  final connection = FakeFirebaseAdapter();
  late FirebaseAuthAdapter firebaseAuth;
  late UserRepository userRepository;
  late SaveUser saveUser;
  late GetUser getUser;
  final List<Map<String, dynamic>> usersSnap = [];
  final userSetUp = UserSetUp(connection);
  final userMock = usersMock.first;

  setUp(() {
    firebaseAuthMock = MockFirebaseAuth(mockUser: mockUser);
    firebaseAuth = FirebaseAuthAdapter(firebaseAuthMock);
    userRepository = UserRepositoryDatabase(firebaseAuth, connection);
    saveUser = SaveUser(userRepository);
    getUser = GetUser(userRepository);
  });

  setUpAll(() async {
    usersSnap.addAll(await userSetUp.users());
  });

  test('Deve atualizar um usuário', () async {
    final mockUser = MockUser(
      uid: usersSnap.first['id'],
      email: 'will@teste.com',
      displayName: 'Willian Oliveira',
    );
    firebaseAuthMock = MockFirebaseAuth(mockUser: mockUser);
    firebaseAuth = FirebaseAuthAdapter(firebaseAuthMock);
    userRepository = UserRepositoryDatabase(firebaseAuth, connection);
    getUser = GetUser(userRepository);
    final userId = usersSnap.first['id'];
    final input = UserModel(
      firstName: 'Roberta',
      lastName: 'Santos',
      email: EmailModel(userMock['email']),
      cpf: CpfModel(userMock['cpf']),
      password: PasswordModel(userMock['password']),
      id: userMock['id'],
    );
    await firebaseAuthMock.signInWithEmailAndPassword(
        email: mockUser.email!, password: '123123');
    await saveUser(input);
    final output = await getUser(userId);
    expect(output.firstName, input.firstName);
    expect(output.lastName, input.lastName);
    expect(output.id, input.id);
  });
}
