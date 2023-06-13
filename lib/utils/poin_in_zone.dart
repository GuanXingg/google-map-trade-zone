import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:point_in_polygon/point_in_polygon.dart';

bool checkPointInPolygon(LatLng checkPos, List<LatLng> zone) {
  final Point checkPoint = Point(x: checkPos.latitude, y: checkPos.longitude);
  final List<Point> zonePoint = zone.map((el) => Point(x: el.latitude, y: el.longitude)).toList();

  bool checked = Poly.isPointInPolygon(checkPoint, zonePoint);
  return checked;
}
