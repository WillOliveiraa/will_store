import 'package:will_store/freight/domain/entities/coord.dart';

class CoordModel extends Coord {
  CoordModel(super.lat, super.long);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'long': long,
    };
  }

  factory CoordModel.fromMap(Map<String, dynamic> map) {
    return CoordModel(
      map['lat'] as double,
      map['long'] as double,
    );
  }
}
