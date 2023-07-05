import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/sections/application/usecases/get_all_section_data.dart';
import 'package:will_store/sections/application/usecases/remove_section.dart';
import 'package:will_store/sections/infra/models/section_model.dart';
import 'package:will_store/sections/infra/repositories/section_data_repository_database.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

import '../../../mocks/items_section_mock.dart';
import '../../../mocks/products_mock.dart';
import '../../../mocks/sections_mock.dart';
import '../utils/section_set_up.dart';

void main() {
  final connection = FakeFirebaseAdapter();
  final storage = MockFirebaseStorage();
  late RemoveSection removeSection;
  late GetAllSectionData getAllSectionData;
  late SectionDataRepositoryDatabase repository;
  final List<Map<String, dynamic>> sectionsSnap = [];
  final sectionSetUp = SectionSetUp(connection);

  setUp(() {
    repository = SectionDataRepositoryDatabase(connection, storage);
    removeSection = RemoveSection(repository);
    getAllSectionData = GetAllSectionData(repository);
  });

  Future<String> initImageInStorage() async {
    final storageRef = storage.ref().child(filename);
    final task = await storageRef.putFile(getFakeImageFile());
    return await task.ref.getDownloadURL();
  }

  test('Deve remove uma sessão ', () async {
    itemsSectionMock.removeLast();
    itemsSectionMock.first['image'] = await initImageInStorage();
    sectionsMock.first['items'] = itemsSectionMock;
    sectionsSnap.addAll(await sectionSetUp.sections(sections: sectionsMock));
    final input = SectionModel.fromMap(sectionsSnap.first);
    await removeSection(input);
    final output = await getAllSectionData();
    expect(output.first.name, sectionsSnap.last['name']);
    expect(output.first.position, sectionsSnap.last['position']);
    expect(output.first.sectionType.index, sectionsSnap.last['sectionType']);
    expect(output.first.items.length, 1);
    expect(output.first.items.first.title,
        sectionsSnap.last['items'].first['title']);
    expect(output.length, 1);
  });
}
