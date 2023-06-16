import 'package:flutter/material.dart';
import 'package:google_map_new/features/delivery/pages/delivery.dart';

import '../../pickup/pages/pick_up.dart';
import '../pages/setting.dart';

PageRouteBuilder home2SettingRoute(RouteSettings settings) => PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => const SettingPage(),
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.ease))
              .animate(animation),
          child: child),
    );

PageRouteBuilder home2DeliveryRoute(RouteSettings settings) => PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => const DeliveryPage(),
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.ease))
              .animate(animation),
          child: child),
    );

PageRouteBuilder home2PickupRoute(RouteSettings settings) => PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => const PickupPage(),
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.ease))
              .animate(animation),
          child: child),
    );
