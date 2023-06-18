import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/catalog/application/factories/repository_factory.dart';
import 'package:will_store/catalog/application/usecases/get_product_by_id.dart';
import 'package:will_store/catalog/application/usecases/save_product.dart';
import 'package:will_store/catalog/infra/factories/database_repository_factory.dart';
import 'package:will_store/catalog/infra/models/dimentions_model.dart';
import 'package:will_store/catalog/infra/models/item_size_model.dart';
import 'package:will_store/catalog/infra/models/product_model.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

import '../../../mocks/products_mock.dart';

void main() async {
  final connection = FakeFirebaseAdapter();
  final storage = MockFirebaseStorage();
  late RepositoryFactory repositoryFactory;
  late SaveProduct saveProduct;
  late GetProductById getProductById;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    repositoryFactory = DatabaseRepositoryFactory(connection, storage);
    saveProduct = SaveProduct(repositoryFactory);
    getProductById = GetProductById(repositoryFactory);
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

  test('Deve salvar um novo produto com uma image no storage', () async {
    final product = ProductModel(
      '1',
      "Product test 1",
      "Product muito bom",
      [getFakeImageFile()],
      [ItemSizeModel("1", "P", 19.99, 5, DimentionsModel("1", 15, 15, 20, 10))],
    );
    final productId = await saveProduct(product);
    final output = await getProductById(productId);
    expect(output.id, productId);
    expect(output.name, product.name);
    expect(output.images?.first,
        contains('https://firebasestorage.googleapis.com'));
  });
}
