import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/checkout/application/factories/database_repository_factory.dart';
import 'package:will_store/checkout/application/factories/repository_factory.dart';
import 'package:will_store/checkout/application/usecases/get_order_by_id.dart';
import 'package:will_store/core/database/fake_farebase_adapter.dart';

import '../../../mocks/orders_mock.dart';

void main() {
  final connection = FakeFirebaseAdapter();
  late GetOrderById getOrderById;
  late RepositoryFactory repositoryFactory;
  final List<Map<String, dynamic>> ordersSnap = [];

  setUp(() {
    repositoryFactory = DatabaseRepositoryFactory(connection);
    getOrderById = GetOrderById(repositoryFactory);
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

  test('Deve buscar uma order pelo id', () async {
    final input = ordersSnap.first['id'];
    final output = await getOrderById(input);
    expect(output['code'], equals("202300000001"));
  });

  test("Deve retornar um erro caso a ordem não seja encontrada", () {
    expect(
        () async => await getOrderById("1"),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, "message", "Order not found")));
  });
}
