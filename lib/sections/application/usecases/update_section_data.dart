import '../domain/entities/section.dart';
import '../repositories/section_data_repository.dart';

class UpdateSectionData {
  final SectionDataRepository _repository;

  UpdateSectionData(this._repository);

  Future<void> call(Section section) async {
    await _repository.updateSectionData(section);
  }
}
