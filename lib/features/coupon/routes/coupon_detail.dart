import 'package:flutter/material.dart';
import 'package:google_map_new/features/user/pages/page_form.dart';

PageRouteBuilder couponDetail2FormRoute(RouteSettings settings) => PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => const FormPage(),
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.ease))
              .animate(animation),
          child: child),
    );
