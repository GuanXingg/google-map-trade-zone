import 'package:google_map_new/models/model_place.dart';
import 'package:google_map_new/models/model_zone.dart';

List<PlaceModel> getAllPlace(List<ZoneModel> zoneData) {
  final List<PlaceModel> placeData = [];

  for (ZoneModel el in zoneData) {
    for (PlaceModel placeEl in el.placeList) placeData.add(placeEl);
  }

  return placeData;
}
