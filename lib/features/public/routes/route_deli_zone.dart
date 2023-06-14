import 'package:flutter/material.dart';
import 'package:google_map_new/models/model_place.dart';

import '../pages/page_coupon_list.dart';

PageRouteBuilder deliZone2CouponRoute(RouteSettings settings) {
  final dynamic args = settings.arguments;
  final PlaceModel placeItem = args['placeItem'] as PlaceModel;

  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (_, __, ___) => CouponPage(placeItem: placeItem),
    transitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (_, animation, __, child) => SlideTransition(
        position:
            Tween(begin: const Offset(0, 1), end: Offset.zero).chain(CurveTween(curve: Curves.ease)).animate(animation),
        child: child),
  );
}
