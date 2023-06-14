import 'package:flutter/material.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Polygon customPolygon(String id, List<LatLng> points, String color) => Polygon(
      polygonId: PolygonId(id),
      points: points,
      fillColor: Color(int.parse(color)).withOpacity(0.2),
      strokeWidth: 2,
      strokeColor: AppColor.third.withOpacity(0.6),
    );
