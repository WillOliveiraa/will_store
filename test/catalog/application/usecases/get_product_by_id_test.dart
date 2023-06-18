import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/catalog/application/factories/repository_factory.dart';
import 'package:will_store/catalog/application/usecases/get_product_by_id.dart';
import 'package:will_store/catalog/infra/factories/database_repository_factory.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

import '../utils/product_set_up.dart';

void main() {
  final connection = FakeFirebaseAdapter();
  final storage = MockFirebaseStorage();
  late RepositoryFactory repositoryFactory;
  late GetProductById getProductById;
  final List<Map<String, dynamic>> productsSnap = [];
  final productSetUp = ProductSetUp(connection);

  setUp(() {
    repositoryFactory = DatabaseRepositoryFactory(connection, storage);
    getProductById = GetProductById(repositoryFactory);
  });

  setUpAll(() async {
    productsSnap.addAll(await productSetUp.products());
  });

  test('Deve buscar um produto pelo id', () async {
    final productId = productsSnap.first['id'];
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
