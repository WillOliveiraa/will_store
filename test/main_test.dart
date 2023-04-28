import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/application/repositories/product_repository.dart';
import 'package:will_store/application/usecases/get_products.dart';
import 'package:will_store/domain/entities/product.dart';
import 'package:will_store/infra/database/fake_farebase_adapter.dart';
import 'package:will_store/infra/repositories/product_repository_database.dart';

void main() async {
  final connection = FakeFirebaseAdapter();
  late ProductRepository repository;
  late GetProducts getProducts;

  setUp(() {
    repository = ProductRepositoryDatabase(connection);
    getProducts = GetProducts(repository);
  });

  test("Deve listar todos os produtos salvos", () async {
    final List<Product> productsMock = [
      Product("1", "Product test 1", "Product muito bom", null, "P"),
      Product("2", "Product test 2", "Product bom", null, "G")
    ];
    final collection = connection.firestore.collection('products');
    for (final item in productsMock) {
      await collection.add({
        'name': item.name,
        'description': item.description,
        'size': item.size,
        'images': item.images,
      });
    }
    final products = await getProducts();
    expect(products.length, equals(2));
    expect(products.first.name, equals('Product test 1'));
    expect(products[1].size, equals('G'));
  });
}
