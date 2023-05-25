import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/catalog/application/usecases/get_product_by_id.dart';
import 'package:will_store/checkout/application/factories/database_repository_factory.dart';
import 'package:will_store/checkout/application/factories/repository_factory.dart';
import 'package:will_store/core/database/fake_farebase_adapter.dart';

import '../../../mocks/products_mock.dart';

void main() {
  final connection = FakeFirebaseAdapter();
  late RepositoryFactory repositoryFactory;
  late GetProductById getProductById;

  setUp(() {
    repositoryFactory = DatabaseRepositoryFactory(connection);
    getProductById = GetProductById(repositoryFactory);
  });

  test('Deve buscar um produto pelo id', () async {
    final collection = connection.firestore.collection('products');
    final snapshot = await collection.add(productsMock.first);
    final productMock = productsMock.first;
    productMock['id'] = snapshot.id;
    final productId = snapshot.id;
    final output = await getProductById(productId);
    expect(output.id, equals(productId));
    expect(output.name, equals("Product test 1"));
  });

  test("Deve retornar um erro caso o produto não seja encontrado", () {
    expect(
        () async => await getProductById("1"),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, "message", "Product not found")));
  });
}
