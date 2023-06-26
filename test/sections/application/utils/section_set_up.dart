import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

import '../../../mocks/sections_mock.dart';

class SectionSetUp {
  final FakeFirebaseAdapter connection;
  late final CollectionReference<Map<String, dynamic>> _sectionsCollection;

  SectionSetUp(this.connection) {
    _sectionsCollection = connection.firestore.collection('sections');
  }

  Future<List<Map<String, dynamic>>> sections() async {
    final List<Map<String, dynamic>> sectionsSnap = [];
    for (final item in sectionsMock) {
      final sectionSnapshot = await _sectionsCollection.add(item);
      item['id'] = sectionSnapshot.id;
      sectionsSnap.add(item);
    }
    return sectionsSnap;
  }
}
