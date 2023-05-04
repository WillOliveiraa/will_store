import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/application/repositories/product_repository.dart';
import 'package:will_store/application/usecases/get_product_by_id.dart';
import 'package:will_store/infra/database/fake_farebase_adapter.dart';
import 'package:will_store/infra/repositories/product_repository_database.dart';

import '../../mocks/products_mock.dart';

void main() {
  final connection = FakeFirebaseAdapter();
  late GetProductById getProductById;
  late ProductRepository repository;

  setUp(() {
    repository = ProductRepositoryDatabase(connection);
    getProductById = GetProductById(repository);
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
