import 'package:flutter/material.dart';

import '../features/public/routes/route_deli.dart';
import '../features/public/routes/route_home.dart';
import '../features/public/routes/route_loading.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  String? filePath = settings.name;

  if (filePath == '/home') return loading2HomeRoute(settings);
  if (filePath == '/settings') return home2SettingRoute(settings);
  if (filePath == '/delivery') return home2DeliRoute(settings);
  if (filePath == '/delivery/search') return deli2DeliSearchRoute(settings);
  if (filePath == '/delivery/zone') return deli2DeliZoneRoute(settings);

  return null;
}
