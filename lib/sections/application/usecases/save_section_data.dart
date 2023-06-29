import '../domain/entities/section.dart';
import '../repositories/section_data_repository.dart';

class SaveSectionData {
  final SectionDataRepository _repository;

  SaveSectionData(this._repository);

  Future<void> call(Section section) async {
    await _repository.saveSectionData(section);
  }
}
