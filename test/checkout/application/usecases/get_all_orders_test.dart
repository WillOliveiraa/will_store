import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/checkout/application/factories/repository_factory.dart';
import 'package:will_store/checkout/application/usecases/get_all_orders.dart';
import 'package:will_store/checkout/infra/factories/database_repository_factory.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

import '../utils/order_set_up.dart';

void main() {
  final connection = FakeFirebaseAdapter();
  late GetAllOrders getAllOrders;
  late RepositoryFactory repositoryFactory;
  final List<Map<String, dynamic>> ordersSnap = [];
  final List<Map<String, dynamic>> itemsOrderSnap = [];
  final orderSetUp = OrderSetUp(connection);

  setUp(() {
    repositoryFactory = DatabaseRepositoryFactory(connection);
    getAllOrders = GetAllOrders(repositoryFactory);
  });

  setUpAll(() async {
    itemsOrderSnap.addAll(await orderSetUp.itemsOrder());
    ordersSnap.addAll(await orderSetUp.orders());
  });

  test("Deve retornar todos os pedidos", () async {
    final output = await getAllOrders();
    expect(output.length, equals(2));
    expect(output.first.items.length, equals(2));
    expect(output.first.items.first.id, equals(itemsOrderSnap.first['id']));
  });
}
