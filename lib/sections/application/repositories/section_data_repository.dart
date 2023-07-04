import '../domain/entities/section.dart';

abstract class SectionDataRepository {
  Future<List<Section>> getAllSectionData();
  Future<void> saveSectionData(Section section);
  Future<void> updateSectionData(Section section);
}
