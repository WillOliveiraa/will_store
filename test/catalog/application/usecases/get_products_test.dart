import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/catalog/application/repositories/product_repository.dart';
import 'package:will_store/catalog/application/usecases/get_products.dart';
import 'package:will_store/catalog/infra/repositories/product_repository_database.dart';
import 'package:will_store/core/database/fake_farebase_adapter.dart';

import '../../../mocks/products_mock.dart';

void main() async {
  final connection = FakeFirebaseAdapter();
  late ProductRepository repository;
  late GetProducts getProducts;

  setUp(() {
    repository = ProductRepositoryDatabase(connection);
    getProducts = GetProducts(repository);
  });

  test("Deve listar todos os produtos salvos", () async {
    final collection = connection.firestore.collection('products');
    final List<Map<String, dynamic>> productsSnap = [];
    for (int i = 0; i < productsMock.length; i++) {
      final snapshot = await collection.add(productsMock[i]);
      final productMock = productsMock[i];
      productMock['id'] = snapshot.id;
      productsSnap.add(productMock);
    }
    final products = await getProducts();
    expect(products.length, equals(3));
    expect(products.first.id, equals(productsSnap.first['id']));
    expect(products.first.name, equals('Product test 1'));
    expect(products.first.itemSize.first.name, equals('P'));
    expect(products.first.itemSize.first.dimentions.width, equals(100));
  });
}
