import 'package:flutter/material.dart';

import '../features/coupon/routes/coupon.dart';
import '../features/coupon/routes/coupon_detail.dart';
import '../features/delivery/routes/delivery.dart';
import '../features/delivery/routes/zone.dart';
import '../features/public/routes/home.dart';
import '../features/public/routes/loading.dart';
import '../features/pickup/routes/pick_up.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  String? filePath = settings.name;

  if (filePath == '/home') return loading2HomeRoute(settings);
  if (filePath == '/settings') return home2SettingRoute(settings);
  if (filePath!.startsWith('/delivery')) {
    if (filePath == '/delivery') return home2DeliveryRoute(settings);
    if (filePath == '/delivery/search') return deli2DeliSearchRoute(settings);
    if (filePath == '/delivery/zone') return deli2DeliZoneRoute(settings);
  }
  if (filePath.startsWith('/coupons')) {
    if (filePath == '/coupons') return deliZone2CouponRoute(settings);
    if (filePath == '/coupons/detail') return coupon2CouponDetailRoute(settings);
  }
  if (filePath.startsWith('/user')) {
    if (filePath == '/user/form') return couponDetail2FormRoute(settings);
  }
  if (filePath.startsWith('/pickup')) {
    if (filePath == '/pickup') return home2PickupRoute(settings);
    if (filePath == '/pickup/all') return pickUp2PickUpAllRoute(settings);
  }

  return null;
}
