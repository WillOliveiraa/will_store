import '../domain/entities/section.dart';

abstract class SectionDataRepository {
  Future<List<Section>> getAllSectionData();
}
