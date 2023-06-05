import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/checkout/application/factories/repository_factory.dart';
import 'package:will_store/checkout/application/usecases/get_orders.dart';
import 'package:will_store/checkout/infra/factories/database_repository_factory.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

import '../../../mocks/orders_mock.dart';

void main() {
  final connection = FakeFirebaseAdapter();
  late GetOrders getOrders;
  late RepositoryFactory repositoryFactory;
  final List<Map<String, dynamic>> ordersSnap = [];

  setUp(() {
    repositoryFactory = DatabaseRepositoryFactory(connection);
    getOrders = GetOrders(repositoryFactory);
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

  test("Deve retornar todos os pedidos", () async {
    final output = await getOrders();
    expect(output.length, equals(1));
  });
}
