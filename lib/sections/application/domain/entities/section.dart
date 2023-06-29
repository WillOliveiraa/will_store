import '../enums/section_type.dart';
import 'section_item.dart';

class Section {
  String? id;
  final String name;
  final SectionType sectionType;
  final List<SectionItem> items;
  final int? position;

  Section({
    this.id,
    required this.name,
    required this.sectionType,
    required this.items,
    this.position,
  });
}
