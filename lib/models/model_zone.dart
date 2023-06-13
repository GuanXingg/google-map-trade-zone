import 'package:google_maps_flutter/google_maps_flutter.dart';

import './model_place.dart';

class ZoneModel {
  late String name;
  late String color;
  late List<LatLng> zone;
  late List<PlaceModel> placeList;

  ZoneModel({
    required this.name,
    required this.color,
    required this.zone,
    required this.placeList,
  });

  ZoneModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
    zone = json['zone'];
    placeList = json['placeList'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'color': color,
        'zone': zone,
        'placeList': placeList.map((el) => el.toJson()).toList(),
      };
}
