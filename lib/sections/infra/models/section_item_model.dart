import '../../application/domain/entities/section_item.dart';

class SectionItemModel extends SectionItem {
  SectionItemModel({
    super.title,
    required super.image,
    super.id,
    super.productId,
  });

  factory SectionItemModel.fromMap(Map<String, dynamic> map) {
    return SectionItemModel(
      image: map['image'] as dynamic,
      productId: map['productId'] == null ? null : map['productId'] as String,
      title: map['title'] == null ? null : map['title'] as String,
      id: map['id'] == null ? null : map['id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'productId': productId,
      'image': image,
    };
  }
}
