import 'package:flutter/material.dart';
import 'package:google_map_new/features/public/pages/page_pick_up.dart';

import '../pages/page_deli.dart';
import '../pages/page_setting.dart';

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

PageRouteBuilder home2DeliRoute(RouteSettings settings) => PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => const DeliPage(),
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
