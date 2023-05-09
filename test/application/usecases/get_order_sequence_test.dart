import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/application/repositories/order_repository.dart';
import 'package:will_store/application/usecases/get_order_sequence.dart';
import 'package:will_store/infra/database/fake_farebase_adapter.dart';
import 'package:will_store/infra/repositories/order_repository_database.dart';

import '../../mocks/orders_mock.dart';

void main() {
  final connection = FakeFirebaseAdapter();
  late GetOrderSequence getOrderSequence;
  late OrderRepository repository;
  final List<Map<String, dynamic>> ordersSnap = [];

  setUp(() {
    repository = OrderRepositoryDatabase(connection);
    getOrderSequence = GetOrderSequence(repository);
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
