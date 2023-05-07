import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/application/repositories/product_repository.dart';
import 'package:will_store/application/usecases/get_products.dart';
import 'package:will_store/infra/database/fake_farebase_adapter.dart';
import 'package:will_store/infra/repositories/product_repository_database.dart';

import '../../mocks/products_mock.dart';

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
    expect(products.length, equals(2));
    expect(products.first.id, equals(productsSnap.first['id']));
    expect(products.first.name, equals('Product test 1'));
    expect(products.first.itemSize.first.name, equals('P'));
    expect(products[1].itemSize[1].dimentions.width, equals(15));
  });
}
