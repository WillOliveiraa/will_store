import '../../application/domain/entities/section.dart';
import '../../application/domain/enums/section_type.dart';
import 'section_item_model.dart';

class SectionModel extends Section {
  SectionModel({
    required super.name,
    required super.sectionType,
    required super.items,
    super.id,
    super.position,
  });

  factory SectionModel.fromMap(Map<String, dynamic> map) {
    return SectionModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      position: map['position'] != null ? map['position'] as int : null,
      sectionType: SectionType.values[map['sectionType'] as int],
      items: List.from(map['items'])
          .map((x) => SectionItemModel.fromMap(x))
          .toList(),
    );
  }
}
