import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/sections/application/usecases/get_all_section_data.dart';
import 'package:will_store/sections/application/usecases/update_section_data.dart';
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
  late UpdateSectionData updateSectionData;
  late GetAllSectionData getAllSectionData;
  late SectionDataRepositoryDatabase repository;
  final List<Map<String, dynamic>> sectionsSnap = [];
  final sectionSetUp = SectionSetUp(connection);

  setUp(() {
    repository = SectionDataRepositoryDatabase(connection, storage);
    updateSectionData = UpdateSectionData(repository);
    getAllSectionData = GetAllSectionData(repository);
  });

  setUpAll(() async {
    sectionsSnap.addAll(await sectionSetUp.sections());
  });

  test('Deve atualizar uma sessão com uma imagem', () async {
    itemsSectionMock.first['image'] = getFakeImageFile();
    sectionsMock.first['items'] = itemsSectionMock;
    final input = SectionModel.fromMap(sectionsMock.first);
    await updateSectionData(input);
    final output = await getAllSectionData();
    expect(output.first.name, sectionsMock.first['name']);
    expect(output.first.position, sectionsMock.first['position']);
    expect(output.first.sectionType.index, sectionsMock.first['sectionType']);
    expect(output.first.items.length, 2);
    expect(output.first.items.first.title,
        sectionsMock.first['items'].first['title']);
    expect(output.first.items.first.image,
        contains('https://firebasestorage.googleapis.com'));
  });
}
