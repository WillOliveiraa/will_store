import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:will_store/infra/database/connection.dart';
import 'package:will_store/infra/models/product_model.dart';

import '../../application/repositories/product_repository.dart';
import '../../domain/entities/product.dart';

class ProductRepositoryDatabase implements ProductRepository {
  final Connection _connection;

  ProductRepositoryDatabase(this._connection);

  @override
  Future<void> save(Product product) async {
    final connect = (_connection.connect() as FirebaseFirestore);
    final productCollection = connect.collection('products');
    await productCollection.add((product as ProductModel).toMap());
  }

  @override
  Future<List<Product>> getProducts() async {
    final connect = (_connection.connect() as FirebaseFirestore);
    final productCollection = connect.collection('products');
    final productsData = await productCollection.get();
    final List<Product> products = [];
    for (final item in productsData.docs) {
      final product = ProductModel.fromMap(item.data());
      products.add(product);
    }
    return products;
  }
}
