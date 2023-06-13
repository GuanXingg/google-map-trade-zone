import 'package:google_map_new/utils/parse_file.dart';
import 'package:google_map_new/utils/pick_file.dart';

Future<List<dynamic>> getPlaceMarkData() async {
  try {
    final String xmlString = await pickStorageFile();
    final Map<String, dynamic> json = parseKml2Json(xmlString);
    final List<dynamic> jsonPlaceMark = json['kml']['Document']['Placemark'];

    return jsonPlaceMark;
  } catch (err) {
    return Future.error('Can not get Place mark data: $err');
  }
}

Future<List<dynamic>> getRawZoneData() async {
  final List<dynamic> zoneData = [];
  final List<dynamic> jsonPlaceMark = await getPlaceMarkData();

  for (dynamic el in jsonPlaceMark) {
    if (el['Polygon'] != null) zoneData.add(el);
  }

  return zoneData;
}

Future<List<dynamic>> getRawPlaceData() async {
  final List<dynamic> placeData = [];
  final List<dynamic> jsonPlaceMark = await getPlaceMarkData();

  for (dynamic el in jsonPlaceMark) {
    if (el['Point'] != null) placeData.add(el);
  }

  return placeData;
}
