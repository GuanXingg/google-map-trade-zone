import 'package:google_map_new/models/model_distance.dart';
import 'package:google_map_new/models/model_place.dart';
import 'package:google_map_new/utils/calculate_distance.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<PointDistanceModel> getPlaceZone(LatLng currentPos, List<PlaceModel> placeList) {
  List<PointDistanceModel> pointDisData = [];

  for (PlaceModel el in placeList) {
    double distance = calculateDistancePoint(currentPos, el.point);
    String disString = calculateDistancePointString(currentPos, el.point);

    final Map<String, dynamic> item = {
      'name': el.name,
      'distance': distance,
      'description': disString,
    };

    pointDisData.add(PointDistanceModel.fromJson(item));
  }

  return pointDisData;
}

List<PointDistanceModel> sortPlaceZone(LatLng currentPos, List<PlaceModel> placeList) {
  List<PointDistanceModel> newPointDisData = getPlaceZone(currentPos, placeList);
  newPointDisData.sort((a, b) => a.distance.compareTo(b.distance));

  return newPointDisData;
}
