import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/sections/application/usecases/get_all_section_data.dart';
import 'package:will_store/sections/infra/repositories/section_data_repository_database.dart';
import 'package:will_store/utils/database/fake_farebase_adapter.dart';

import '../utils/section_set_up.dart';

void main() async {
  final connection = FakeFirebaseAdapter();
  late GetAllSectionData getAllSectionData;
  late SectionDataRepositoryDatabase repository;
  final sectionSetUp = SectionSetUp(connection);
  final List<Map<String, dynamic>> sectionsSnap = [];

  setUp(() {
    repository = SectionDataRepositoryDatabase(connection);
    getAllSectionData = GetAllSectionData(repository);
  });

  setUpAll(() async {
    sectionsSnap.addAll(await sectionSetUp.sections());
  });

  test('Deve carregar todos as sessões', () async {
    final output = await getAllSectionData();
    expect(output.length, 2);
    expect(output.first.id, sectionsSnap.first['id']);
    expect(output.first.name, sectionsSnap.first['name']);
    expect(output.first.items.first.title,
        sectionsSnap.first['items'].first['title']);
  });
}
