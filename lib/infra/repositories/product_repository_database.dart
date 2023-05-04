import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:will_store/infra/database/connection.dart';
import 'package:will_store/infra/models/product_model.dart';

import '../../application/repositories/product_repository.dart';
import '../../domain/entities/product.dart';

class ProductRepositoryDatabase implements ProductRepository {
  final Connection _connection;
  final productsCollection = 'products';

  ProductRepositoryDatabase(this._connection);

  @override
  Future<void> save(Product product) async {
    final productCollection = _connect.collection(productsCollection);
    await productCollection.add((product as ProductModel).toMap());
  }

  @override
  Future<List<Product>> getProducts() async {
    final productCollection = _connect.collection(productsCollection);
    final productsData = await productCollection.get();
    final List<Product> products = [];
    for (final item in productsData.docs) {
      final product = ProductModel.fromMap(_setId(item));
      products.add(product);
    }
    return products;
  }

  @override
  Future<Product> getProductById(String id) async {
    final productData = await _getFirestoreRef(id).get();
    if (!productData.exists) throw ArgumentError("Product not found");
    return ProductModel.fromMap(_setId(productData));
  }

  FirebaseFirestore get _connect =>
      (_connection.connect() as FirebaseFirestore);

  DocumentReference _getFirestoreRef(String id) {
    return _connect.doc('$productsCollection/$id');
  }

  Map<String, dynamic> _setId(DocumentSnapshot<Object?> productData) {
    final data = productData.data() as Map<String, dynamic>;
    data['id'] = productData.id;
    return data;
  }
}
