import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/application/repositories/order_repository.dart';
import 'package:will_store/application/usecases/save_order.dart';
import 'package:will_store/infra/database/fake_farebase_adapter.dart';
import 'package:will_store/infra/models/order_model.dart';
import 'package:will_store/infra/models/product_model.dart';
import 'package:will_store/infra/repositories/order_repository_database.dart';

import '../../mocks/products_mock.dart';

void main() {
  final connection = FakeFirebaseAdapter();
  late OrderRepository repository;
  late SaveOrder saveOrder;

  setUp(() {
    repository = OrderRepositoryDatabase(connection);
    saveOrder = SaveOrder(repository);
  });

  test('Deve salvar uma nova ordem', () async {
    final product = ProductModel.fromMap(productsMock.first);
    final input = OrderModel(
      id: "1",
      cpf: "407.302.170-27",
    );
    input.addItem(product, 1);
    await saveOrder(input);
    final ordersCollection =
        await connection.firestore.collection('orders').get();
    final orderData = ordersCollection.docs.first.data();
    expect(ordersCollection.size, equals(1));
    expect(orderData['cpf'], equals(input.cpf.value));
    expect(orderData['sequence'], equals(1));
  });
}
