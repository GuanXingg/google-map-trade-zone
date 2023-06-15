import 'package:flutter/material.dart';

import '../features/public/routes/route_coupon.dart';
import '../features/public/routes/route_coupon_detail.dart';
import '../features/public/routes/route_deli.dart';
import '../features/public/routes/route_deli_zone.dart';
import '../features/public/routes/route_home.dart';
import '../features/public/routes/route_loading.dart';
import '../features/public/routes/route_pick_up.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  String? filePath = settings.name;

  if (filePath == '/home') return loading2HomeRoute(settings);
  if (filePath == '/settings') return home2SettingRoute(settings);
  if (filePath == '/delivery') return home2DeliRoute(settings);
  if (filePath == '/delivery/search') return deli2DeliSearchRoute(settings);
  if (filePath == '/delivery/zone') return deli2DeliZoneRoute(settings);
  if (filePath == '/coupons') return deliZone2CouponRoute(settings);
  if (filePath == '/coupons/detail') return coupon2CouponDetailRoute(settings);
  if (filePath == '/user/form') return couponDetail2FormRoute(settings);
  if (filePath == '/pickup') return home2PickupRoute(settings);
  if (filePath == '/pickup/all') return pickUp2PickUpAllRoute(settings);

  return null;
}
