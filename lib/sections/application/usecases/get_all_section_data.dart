import '../domain/entities/section.dart';
import '../repositories/section_data_repository.dart';

class GetAllSectionData {
  final SectionDataRepository _repository;

  GetAllSectionData(this._repository);

  Future<List<Section>> call() async {
    return _repository.getAllSectionData();
  }
}
