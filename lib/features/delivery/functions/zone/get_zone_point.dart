import 'package:google_map_new/models/model_zone.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<List<LatLng>> getAllZonePoint(List<ZoneModel> zoneData) async {
  final List<LatLng> allZonePos = [];

  for (ZoneModel el in zoneData) {
    for (LatLng zoneEl in el.zone) allZonePos.add(zoneEl);
  }

  return allZonePos;
}
