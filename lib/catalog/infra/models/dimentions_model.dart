import 'package:will_store/catalog/domain/entities/dimentions.dart';

class DimentionsModel extends Dimentions {
  DimentionsModel(
      super.id, super.width, super.height, super.length, super.weight);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'width': width,
      'height': height,
      'length': length,
      'weight': weight,
    };
  }

  factory DimentionsModel.fromMap(Map<String, dynamic> map) {
    return DimentionsModel(
      map['id'] != null ? map['id'] as String : null,
      map['width'] as num,
      map['height'] as num,
      map['length'] as num,
      map['weight'] as num,
    );
  }
}
