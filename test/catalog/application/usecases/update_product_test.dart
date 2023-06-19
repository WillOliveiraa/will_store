import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/catalog/application/factories/repository_factory.dart';
import 'package:will_store/catalog/application/usecases/get_product_by_id.dart';
import 'package:will_store/catalog/application/usecases/update_product.dart';
import 'package:will_store/catalog/infra/factories/database_repository_factory.dart';
import 'package:will_store/catalog/infra/models/product_model.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

import '../../../mocks/products_mock.dart';
import '../utils/product_set_up.dart';

void main() {
  final connection = FakeFirebaseAdapter();
  final storage = MockFirebaseStorage();
  late RepositoryFactory repositoryFactory;
  late UpdateProduct updateProduct;
  late GetProductById getProductById;
  final List<Map<String, dynamic>> productsSnap = [];
  final productSetUp = ProductSetUp(connection);

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    repositoryFactory = DatabaseRepositoryFactory(connection, storage);
    updateProduct = UpdateProduct(repositoryFactory);
    getProductById = GetProductById(repositoryFactory);
  });

  setUpAll(() async {
    productsSnap.addAll(await productSetUp.products());
  });

  test('Deve atualizar os dados de um produto', () async {
    final productMap = productsSnap.first;
    productMap['name'] = 'Iphone 14 Pro Max';
    productMap['description'] = 'O melhor da atualidade';
    productMap['itemSize'][0]['price'] = 10000;
    productMap['images'] = [
      getFakeImageFile(),
      "https://github.com/WillOliveiraa.png"
    ];
    final product = ProductModel.fromMap(productMap);
    await updateProduct(product);
    final output = await getProductById(product.id!);
    expect(output.id, product.id!);
    expect(output.name, product.name);
    expect(output.description, product.description);
    expect(output.images?.length, 2);
  });
}
