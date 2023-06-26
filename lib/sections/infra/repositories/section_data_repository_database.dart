import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/constant.dart';
import '../../../utils/database/database_connection.dart';
import '../../application/domain/entities/section.dart';
import '../../application/repositories/section_data_repository.dart';
import '../models/section_model.dart';

class SectionDataRepositoryDatabase implements SectionDataRepository {
  final DatabaseConnection _connection;

  SectionDataRepositoryDatabase(this._connection);

  @override
  Future<List<Section>> getAllSectionData() async {
    final sectionsCollection =
        await _sectionReference().orderBy('position').get();
    final sectionsData = sectionsCollection.docs
        .map((item) => SectionModel.fromMap(_setId(item)))
        .toList();
    return sectionsData;
  }

  FirebaseFirestore get _connect =>
      (_connection.connect() as FirebaseFirestore);

  // DocumentReference _getFirestoreRef(String id) {
  //   return _connect.doc('$sectionsCollection/$id');
  // }

  CollectionReference _sectionReference() {
    return _connect.collection(sectionsCollection);
  }

  Map<String, dynamic> _setId(DocumentSnapshot<Object?> sectionData) {
    final data = sectionData.data() as Map<String, dynamic>;
    data['id'] = sectionData.id;
    return data;
  }
}
