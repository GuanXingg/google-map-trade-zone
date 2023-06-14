import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes/google_maps_routes.dart';

double calculateDistancePoint(LatLng fromPos, LatLng toPos) {
  DistanceCalculator distanceCalculator = DistanceCalculator();

  String disString = distanceCalculator.calculateRouteDistance([fromPos, toPos], decimals: 3);
  List<String> splitDisString = disString.split(' ');
  double distance = double.parse(splitDisString[0]);

  return distance;
}

String calculateDistancePointString(LatLng fromPos, LatLng toPos) {
  DistanceCalculator distanceCalculator = DistanceCalculator();

  String disString = distanceCalculator.calculateRouteDistance([fromPos, toPos], decimals: 3);

  return disString;
}
