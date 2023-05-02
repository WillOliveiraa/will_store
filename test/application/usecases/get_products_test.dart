import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/application/repositories/product_repository.dart';
import 'package:will_store/application/usecases/get_products.dart';
import 'package:will_store/infra/database/fake_farebase_adapter.dart';
import 'package:will_store/infra/models/dimentions_model.dart';
import 'package:will_store/infra/models/item_size_model.dart';
import 'package:will_store/infra/models/product_model.dart';
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
    final List<ProductModel> productsMock = [
      ProductModel("1", "Product test 1", "Product muito bom", null, [
        ItemSizeModel("1", "P", 19.99, 5, DimentionsModel("1", 15, 15, 20, 10))
      ]),
      ProductModel("2", "Product test 2", "Product bom", null,
          [ItemSizeModel("1", "G", 22.99, 10, null)])
    ];
    final collection = connection.firestore.collection('products');
    for (final item in productsMock) {
      await collection.add({
        'name': item.name,
        'description': item.description,
        'itemSize': item.itemSize.map((x) => x.toMap()).toList(),
        'images': item.images,
      });
    }
    final products = await getProducts();
    expect(products.length, equals(2));
    expect(products.first.name, equals('Product test 1'));
    expect((products.first.itemSize as List<ItemSizeModel>).first.name,
        equals('P'));
    expect(
        ((products.first.itemSize as List<ItemSizeModel>).first.dimentions
                as DimentionsModel)
            .width,
        equals(15));
  });
}
