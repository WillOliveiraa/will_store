import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/checkout/application/factories/repository_factory.dart';
import 'package:will_store/checkout/application/usecases/get_my_orders.dart';
import 'package:will_store/checkout/infra/factories/database_repository_factory.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

import '../utils/order_set_up.dart';

void main() {
  final connection = FakeFirebaseAdapter();
  late GetMyOrders getMyOrders;
  late RepositoryFactory repositoryFactory;
  final List<Map<String, dynamic>> ordersSnap = [];
  final List<Map<String, dynamic>> itemsOrderSnap = [];
  final orderSetUp = OrderSetUp(connection);

  setUp(() {
    repositoryFactory = DatabaseRepositoryFactory(connection);
    getMyOrders = GetMyOrders(repositoryFactory);
  });

  setUpAll(() async {
    itemsOrderSnap.addAll(await orderSetUp.itemsOrder());
    ordersSnap.addAll(await orderSetUp.orders());
  });

  test("Deve retornar os meus pedidos", () async {
    const userId = '1';
    final output = await getMyOrders(userId);
    expect(output.length, 1);
    expect(output.first.items.length, 2);
    expect(output.first.items.first.id, itemsOrderSnap.first['id']);
    expect(output.first.date.isAtSameMomentAs(DateTime(2023, 06, 01, 10, 0, 0)),
        isTrue);
  });
}
