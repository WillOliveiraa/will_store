import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/catalog/application/repositories/product_repository.dart';
import 'package:will_store/catalog/application/usecases/save_product.dart';
import 'package:will_store/catalog/infra/models/dimentions_model.dart';
import 'package:will_store/catalog/infra/models/item_size_model.dart';
import 'package:will_store/catalog/infra/models/product_model.dart';
import 'package:will_store/catalog/infra/repositories/product_repository_database.dart';
import 'package:will_store/core/database/fake_farebase_adapter.dart';

void main() async {
  final connection = FakeFirebaseAdapter();
  late ProductRepository repository;
  late SaveProduct saveProduct;

  setUp(() {
    repository = ProductRepositoryDatabase(connection);
    saveProduct = SaveProduct(repository);
  });

  test("Deve salvar um novo produto no banco de dados", () async {
    final product = ProductModel(
      "1",
      "Product test 1",
      "Product muito bom",
      ["https://github.com/WillOliveiraa.png"],
      [ItemSizeModel("1", "P", 19.99, 5, DimentionsModel("1", 15, 15, 20, 10))],
    );
    await saveProduct(product);
    final collection = connection.firestore.collection('products');
    final productsCollection = await collection.get();
    final productData = productsCollection.docs[0].data();
    expect(productsCollection.size, equals(1));
    expect(productData['name'], equals('Product test 1'));
    expect(productData['itemSize'][0]['name'], equals('P'));
    expect(productData['itemSize'][0]['dimentions']['width'], equals(15));
  });
}
