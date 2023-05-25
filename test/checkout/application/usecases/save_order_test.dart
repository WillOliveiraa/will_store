import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/catalog/infra/models/product_model.dart';
import 'package:will_store/checkout/application/factories/database_repository_factory.dart';
import 'package:will_store/checkout/application/factories/repository_factory.dart';
import 'package:will_store/checkout/application/usecases/save_order.dart';
import 'package:will_store/checkout/infra/models/order_model.dart';
import 'package:will_store/core/database/fake_farebase_adapter.dart';

import '../../../mocks/products_mock.dart';

void main() {
  final connection = FakeFirebaseAdapter();
  late RepositoryFactory repositoryFactory;
  late SaveOrder saveOrder;

  setUp(() {
    repositoryFactory = DatabaseRepositoryFactory(connection);
    saveOrder = SaveOrder(repositoryFactory);
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
