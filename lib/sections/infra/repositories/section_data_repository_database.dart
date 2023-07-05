import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/constant.dart';
import '../../../utils/database/database_connection.dart';
import '../../../utils/helpers/firebase_errors.dart';
import '../../application/domain/entities/section.dart';
import '../../application/repositories/section_data_repository.dart';
import '../models/section_item_model.dart';
import '../models/section_model.dart';

class SectionDataRepositoryDatabase implements SectionDataRepository {
  final DatabaseConnection _connection;
  final FirebaseStorage _storage;

  SectionDataRepositoryDatabase(this._connection, this._storage);

  @override
  Future<List<Section>> getAllSectionData() async {
    final sectionsCollection =
        await _sectionReference().orderBy('position').get();
    final sectionsData = sectionsCollection.docs
        .map((item) => SectionModel.fromMap(_setId(item)))
        .toList();
    return sectionsData;
  }

  @override
  Future<void> saveSectionData(Section section) async {
    final reference = await _sectionReference()
        .add((section as SectionModel).toMapWithoutItems());
    section.id = reference.id;
    await _setUrlImages(section);
    await _updateSectionImages(section);
  }

  @override
  Future<void> updateSectionData(Section section) async {
    if (section.id != null) {
      await _setUrlImages(section);
      await _getFirestoreRef(section.id!)
          .update((section as SectionModel).toMap());
    }
  }

  @override
  Future<void> removeSection(String sectionId) async {
    await _getFirestoreRef(sectionId).delete();
  }

  Future<void> _setUrlImages(Section section) async {
    for (int i = 0; i < section.items.length; i++) {
      final item = section.items[i];
      if (item.image is File) {
        final imageUrl = await _saveImageToStorage(item.image, section.id!);
        final sectionItem = SectionItemModel(
          image: imageUrl,
          title: item.title,
          productId: item.productId,
          id: item.id,
        );
        section.items.removeAt(i);
        section.items.insert(i, sectionItem);
      }
    }
  }

  Future<void> _updateSectionImages(Section section) async {
    final items = (section as SectionModel).toListItems();
    await _getFirestoreRef(section.id!)
        .update({itemsCollectionSectionItemAtribute: items});
  }

  FirebaseFirestore get _connect =>
      (_connection.connect() as FirebaseFirestore);

  CollectionReference _sectionReference() {
    return _connect.collection(sectionsCollection);
  }

  DocumentReference _getFirestoreRef(String id) {
    return _sectionReference().doc(id);
  }

  Map<String, dynamic> _setId(DocumentSnapshot<Object?> sectionData) {
    final data = sectionData.data() as Map<String, dynamic>;
    data['id'] = sectionData.id;
    return data;
  }

  // Storage
  Future<String> _saveImageToStorage(dynamic image, String sectionId) async {
    try {
      final storageReference = _storageRef.child(sectionId);
      final task =
          storageReference.child(const Uuid().v1()).putFile(image as File);
      final snapshot = await task;
      return await snapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw ArgumentError(getErrorString(e.code));
    }
  }

  @override
  Future<void> removeImageFromStorage(String urlImage) async {
    final reference = _storage.refFromURL(urlImage);
    await reference.delete();
  }

  Reference get _storageRef => _storage.ref().child('$sectionsCollection/');
}
