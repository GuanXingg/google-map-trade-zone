import 'package:google_map_new/models/model_place.dart';
import 'package:google_map_new/models/model_zone.dart';
import 'package:google_map_new/utils/poin_in_zone.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<ZoneModel> getZoneData(List<dynamic> rawZone, List<PlaceModel> placeData) {
  final List<ZoneModel> zoneData = [];

  try {
    for (dynamic el in rawZone) {
      final String rawName = el['name'];
      final String rawStyle = el['styleUrl'];
      final String rawZone = el['Polygon']['outerBoundaryIs']['LinearRing']['coordinates'];

      final List<String> splitStyle = rawStyle.trim().split('-');
      final List<String> splitZone = rawZone.trim().split(' ');
      splitZone.removeWhere((splitZoneEl) => splitZoneEl.isEmpty);
      final List<List<String>> splitZoneSpec = splitZone.map((splitZoneEl) => splitZoneEl.split(',')).toList();

      final String name = rawName.trim();
      final String color = '0xFF${splitStyle[1]}';
      final List<LatLng> zone = splitZoneSpec
          .map((splitZoneSpecEl) => LatLng(double.parse(splitZoneSpecEl[1]), double.parse(splitZoneSpecEl[0])))
          .toList();

      final List<PlaceModel> placeList = [];
      for (PlaceModel placeEl in placeData) {
        bool checked = checkPointInPolygon(placeEl.point, zone);
        if (checked) placeList.add(placeEl);
      }

      final Map<String, dynamic> item = {
        'name': name,
        'color': color,
        'zone': zone,
        'placeList': placeList,
      };

      zoneData.add(ZoneModel.fromJson(item));
    }
  } catch (err) {
    throw 'Can not convert to zone data';
  }

  return zoneData;
}
