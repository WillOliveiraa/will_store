import '../domain/entities/section.dart';
import '../repositories/section_data_repository.dart';

class RemoveSection {
  final SectionDataRepository _repository;

  RemoveSection(this._repository);

  Future<void> call(Section section) async {
    for (final item in section.items) {
      if (item.image is String) {
        await _repository.removeImageFromStorage(item.image.toString());
      }
    }
    await _repository.removeSection(section.id!);
  }
}
