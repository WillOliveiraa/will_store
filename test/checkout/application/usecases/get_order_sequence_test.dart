import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/checkout/application/factories/repository_factory.dart';
import 'package:will_store/checkout/application/usecases/get_order_sequence.dart';
import 'package:will_store/checkout/infra/factories/database_repository_factory.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

import '../utils/order_set_up.dart';

void main() {
  final connection = FakeFirebaseAdapter();
  late GetOrderSequence getOrderSequence;
  late RepositoryFactory repositoryFactory;
  final List<Map<String, dynamic>> ordersSnap = [];
  final List<Map<String, dynamic>> itemsOrderSnap = [];
  final orderSetUp = OrderSetUp(connection);

  setUp(() {
    repositoryFactory = DatabaseRepositoryFactory(connection);
    getOrderSequence = GetOrderSequence(repositoryFactory);
  });

  setUpAll(() async {
    itemsOrderSnap.addAll(await orderSetUp.itemsOrder());
    ordersSnap.addAll(await orderSetUp.orders());
  });

  test('Deve buscar uma sequencia nova da ordem', () async {
    final output = await getOrderSequence();
    expect(output, equals(1));
  });
}
