import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/checkout/application/factories/repository_factory.dart';
import 'package:will_store/checkout/application/usecases/get_order_sequence.dart';
import 'package:will_store/checkout/infra/factories/database_repository_factory.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

import '../../../mocks/orders_mock.dart';

void main() {
  final connection = FakeFirebaseAdapter();
  late GetOrderSequence getOrderSequence;
  late RepositoryFactory repositoryFactory;
  final List<Map<String, dynamic>> ordersSnap = [];

  setUp(() {
    repositoryFactory = DatabaseRepositoryFactory(connection);
    getOrderSequence = GetOrderSequence(repositoryFactory);
  });

  setUpAll(() async {
    final collection = connection.firestore.collection('orders');
    for (int i = 0; i < ordersMock.length; i++) {
      final snapshot = await collection.add(ordersMock[i]);
      final orderMock = ordersMock[i];
      orderMock['id'] = snapshot.id;
      ordersSnap.add(orderMock);
    }
  });

  test('Deve buscar uma sequencia nova da ordem', () async {
    final output = await getOrderSequence();
    expect(output, equals(1));
  });
}
