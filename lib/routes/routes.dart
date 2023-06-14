import 'package:flutter/material.dart';

import '../features/public/routes/route_coupon.dart';
import '../features/public/routes/route_coupon_detail.dart';
import '../features/public/routes/route_deli.dart';
import '../features/public/routes/route_deli_zone.dart';
import '../features/public/routes/route_home.dart';
import '../features/public/routes/route_loading.dart';

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

  return null;
}
