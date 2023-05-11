import 'dart:math';

import 'coord.dart';

class DistanceCalculator {
  static num calculate(Coord from, Coord to) {
    if (from.lat == to.lat && from.long == to.long) return 0;
    final radlat1 = (pi * from.lat) / 180;
    final radlat2 = (pi * to.lat) / 180;
    final theta = from.long - to.long;
    final radtheta = (pi * theta) / 180;
    num dist = sin(radlat1) * sin(radlat2) +
        cos(radlat1) * cos(radlat2) * cos(radtheta);
    if (dist > 1) dist = 1;
    dist = acos(dist);
    dist = (dist * 180) / pi;
    dist = dist * 60 * 1.1515;
    dist = dist * 1.609344; //convert miles to km
    return dist;
  }
}
