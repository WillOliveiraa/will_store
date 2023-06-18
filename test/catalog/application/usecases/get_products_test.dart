import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/catalog/application/factories/repository_factory.dart';
import 'package:will_store/catalog/application/usecases/get_products.dart';
import 'package:will_store/catalog/infra/factories/database_repository_factory.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

import '../utils/product_set_up.dart';

void main() async {
  final connection = FakeFirebaseAdapter();
  final storage = MockFirebaseStorage();
  late RepositoryFactory repositoryFactory;
  late GetProducts getProducts;
  final List<Map<String, dynamic>> productsSnap = [];
  final productSetUp = ProductSetUp(connection);

  setUp(() {
    repositoryFactory = DatabaseRepositoryFactory(connection, storage);
    getProducts = GetProducts(repositoryFactory);
  });

  setUpAll(() async {
    productsSnap.addAll(await productSetUp.products());
  });

  test("Deve listar todos os produtos salvos", () async {
    final products = await getProducts();
    expect(products.length, equals(3));
    expect(products.first.id, equals(productsSnap.first['id']));
    expect(products.first.name, equals('Product test 1'));
    expect(products.first.itemSize.first.name, equals('P'));
    expect(products.first.itemSize.first.dimentions.width, equals(100));
  });
}
