import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLngBounds getBoundView(LatLng currentPos, List<LatLng> currentZone) {
  final List<LatLng> allPoint = [];

  allPoint.add(currentPos);
  for (LatLng el in currentZone) allPoint.add(el);

  double minLat = allPoint.reduce((v, e) => (v.latitude < e.latitude) ? v : e).latitude;
  double minLong = allPoint.reduce((v, e) => (v.longitude < e.longitude) ? v : e).longitude;
  double maxLat = allPoint.reduce((v, e) => (v.latitude < e.latitude) ? e : v).latitude;
  double maxLong = allPoint.reduce((v, e) => (v.longitude < e.longitude) ? e : v).longitude;

  LatLngBounds bounds = LatLngBounds(southwest: LatLng(minLat, minLong), northeast: LatLng(maxLat, maxLong));

  return bounds;
}
