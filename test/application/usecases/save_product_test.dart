import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/application/repositories/product_repository.dart';
import 'package:will_store/application/usecases/save_product.dart';
import 'package:will_store/domain/entities/item_size.dart';
import 'package:will_store/domain/entities/product.dart';
import 'package:will_store/infra/database/fake_farebase_adapter.dart';
import 'package:will_store/infra/repositories/product_repository_database.dart';

void main() async {
  final connection = FakeFirebaseAdapter();
  late ProductRepository repository;
  late SaveProduct saveProduct;

  setUp(() {
    repository = ProductRepositoryDatabase(connection);
    saveProduct = SaveProduct(repository);
  });

  test("Deve salvar um novo produto no banco de dados", () async {
    final product = Product("1", "Product test 1", "Product muito bom", null,
        [ItemSize("1", "P", 19.99, 5, null)]);
    await saveProduct(product);
    final collection = connection.firestore.collection('products');
    final productsData = await collection.get();
    expect(productsData.size, equals(1));
    expect(productsData.docs[0]['name'], equals('Product test 1'));
  });
}
