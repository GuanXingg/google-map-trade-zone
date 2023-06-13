import 'package:flutter/material.dart';

import '../pages/page_setting.dart';

PageRouteBuilder home2SettingRoute(RouteSettings settings) => PageRouteBuilder(
      pageBuilder: (_, __, ___) => const SettingPage(),
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.ease))
              .animate(animation),
          child: child),
    );
