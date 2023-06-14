import 'package:google_map_new/models/model_zone.dart';
import 'package:google_map_new/utils/calculate_distance.dart';
import 'package:google_map_new/utils/poin_in_zone.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

int getIndexMinZonePos(LatLng currentPos, List<LatLng> allZonePos) {
  int index = -1;
  double distancePoint = double.infinity;

  for (int i = 0; i < allZonePos.length; i++) {
    double tempDis = calculateDistancePoint(currentPos, allZonePos[i]);
    if (tempDis < distancePoint) {
      distancePoint = tempDis;
      index = i;
    }
  }

  return index;
}

int getMinZone(LatLng currentPos, List<LatLng> allZonePos, List<ZoneModel> zoneData) {
  final int indexMinZonePos = getIndexMinZonePos(currentPos, allZonePos);
  final LatLng minZonePos = allZonePos[indexMinZonePos];

  for (int i = 0; i < zoneData.length; i++) {
    bool checked = checkPointInPolygon(minZonePos, zoneData[i].zone);
    if (checked) return i;
  }

  return -1;
}
