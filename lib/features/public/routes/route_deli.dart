import 'package:flutter/material.dart';

import '../pages/page_deli_search.dart';

PageRouteBuilder deli2DeliSearchRoute(RouteSettings settings) => PageRouteBuilder(
      pageBuilder: (_, __, ___) => const DeliSearchPage(),
      transitionDuration: const Duration(milliseconds: 100),
      transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
    );
