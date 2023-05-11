import 'coord.dart';

class ZipCode {
  final String code;
  final String street;
  final String neighborhood;
  final Coord coord;

  ZipCode(this.code, this.street, this.neighborhood, num lat, num long)
      : coord = Coord(lat, long) {
    if (code.trim().isEmpty) throw ArgumentError("Invalid code");
    if (street.trim().isEmpty) throw ArgumentError("Invalid street");
    if (neighborhood.trim().isEmpty) {
      throw ArgumentError("Invalid neighborhood");
    }
  }
}
