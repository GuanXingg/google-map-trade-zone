import 'package:flutter/material.dart';

import '../pages/zone.dart';
import '../pages/search.dart';

PageRouteBuilder deli2DeliSearchRoute(RouteSettings settings) {
  final dynamic args = settings.arguments;
  final TextEditingController controller = args['searchController'] as TextEditingController;
  final void Function() handleSubmit = args['handleSubmit'] as void Function();

  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (_, __, ___) => DeliverySearchPage(controller: controller, handleSubmit: handleSubmit),
    transitionDuration: const Duration(milliseconds: 100),
    transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
  );
}

PageRouteBuilder deli2DeliZoneRoute(RouteSettings settings) => PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => const DeliZonePage(),
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.ease))
              .animate(animation),
          child: child),
    );
