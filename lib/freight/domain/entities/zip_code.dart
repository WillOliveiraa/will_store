import 'package:will_store/freight/domain/entities/city.dart';
import 'package:will_store/freight/domain/entities/uf.dart';

import 'coord.dart';

class ZipCode {
  final String code;
  final String street;
  final String neighborhood;
  final City city;
  final Uf uf;
  final Coord coord;

  ZipCode(this.code, this.street, this.neighborhood, this.city, this.uf,
      double lat, double long)
      : coord = Coord(lat, long) {
    if (code.trim().isEmpty) throw ArgumentError("Invalid code");
    if (street.trim().isEmpty) throw ArgumentError("Invalid street");
    if (neighborhood.trim().isEmpty) {
      throw ArgumentError("Invalid neighborhood");
    }
  }
}
