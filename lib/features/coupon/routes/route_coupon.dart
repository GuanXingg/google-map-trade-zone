import 'package:flutter/material.dart';
import 'package:google_map_new/models/model_coupon.dart';

import '../pages/page_detail.dart';

PageRouteBuilder coupon2CouponDetailRoute(RouteSettings settings) {
  final dynamic args = settings.arguments;
  final CouponModel couponItem = args['couponItem'] as CouponModel;

  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (_, __, ___) => CouponDetailPage(couponItem: couponItem),
    transitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (_, animation, __, child) => SlideTransition(
        position:
            Tween(begin: const Offset(1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.ease)).animate(animation),
        child: child),
  );
}
