import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:will_store/utils/constant.dart';
import 'package:will_store/utils/database/database_connection.dart';
import 'package:will_store/utils/helpers/firebase_errors.dart';

import '../../application/repositories/product_repository.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

class ProductRepositoryDatabase implements ProductRepository {
  final DatabaseConnection _connection;
  final FirebaseStorage _storage;

  ProductRepositoryDatabase(this._connection, this._storage);

  @override
  Future<String> save(Product product) async {
    List<dynamic>? imagesToUpdate;
    if (product.images != null) {
      imagesToUpdate = List<dynamic>.from(product.images!);
      product.images = null;
    }
    final productCollection = _connect.collection(productsCollection);
    final reference =
        await productCollection.add((product as ProductModel).toMap());
    product.id = reference.id;
    if (imagesToUpdate != null) {
      product.images = imagesToUpdate;
      await _setUrlImages(product);
      _updateProductImages(product.images!, product.id!);
    }
    return reference.id;
  }

  @override
  Future<void> update(Product product) async {
    if (product.id != null) {
      await _setUrlImages(product);
      final reference = _getFirestoreRef(product.id!);
      reference.set((product as ProductModel).toMap());
    }
  }

  Future<void> _setUrlImages(Product product) async {
    if (product.images != null) {
      for (int i = 0; i < product.images!.length; i++) {
        final item = product.images![i];
        if (item is File) {
          final imageUrl = await saveImageToStorage(item, product.id!);
          product.images?.removeAt(i);
          product.images?.insert(i, imageUrl);
        }
      }
    }
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

  Future<void>? _updateProductImages(
      List<dynamic> updateImages, String productId) async {
    _getFirestoreRef(productId)
        .update({imagesCollectionAtribute: updateImages});
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

  ///Storage
  @override
  Future<String> saveImageToStorage(dynamic image, String productId) async {
    try {
      final storageReference = _storageRef.child(productId);
      final task =
          storageReference.child(const Uuid().v1()).putFile(image as File);
      final snapshot = await task;
      return await snapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw ArgumentError(getErrorString(e.code));
    }
  }

  Reference get _storageRef => _storage.ref().child('$productsCollection/');

  @override
  Future<void> updateProductImages(
      List<String> images, String productId) async {
    await _getFirestoreRef(productId)
        .update({imagesCollectionAtribute: images});
  }
}
