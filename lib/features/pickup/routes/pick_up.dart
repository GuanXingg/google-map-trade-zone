import 'package:flutter/material.dart';
import 'package:google_map_new/models/model_distance.dart';
import 'package:google_map_new/models/model_place.dart';

import '../pages/all_place.dart';

PageRouteBuilder pickUp2PickUpAllRoute(RouteSettings settings) {
  final dynamic args = settings.arguments;

  final int indexSelected = args['indexSelected'] as int;
  final List<PlaceModel> placeData = args['placeData'] as List<PlaceModel>;
  final List<PointDistanceModel> placeDisData = args['placeDisData'] as List<PointDistanceModel>;
  final void Function(int) onTap = args['onTap'] as void Function(int);

  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (_, __, ___) => PickupPlaceAllPage(
      indexSelected: indexSelected,
      placeData: placeData,
      placeDisData: placeDisData,
      onTap: onTap,
    ),
    transitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (_, animation, __, child) => SlideTransition(
        position:
            Tween(begin: const Offset(1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.ease)).animate(animation),
        child: child),
  );
}
