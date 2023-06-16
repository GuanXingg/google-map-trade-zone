import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './constants/const_color.dart';
import 'features/public/pages/page_loading.dart';
import './providers/provider_location.dart';
import './providers/provider_zone.dart';
import './routes/routes.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ZoneProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: MaterialApp(
        title: 'Google Map',
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute,
        theme: ThemeData(
          primarySwatch: AppBaseColor.primary,
          appBarTheme: const AppBarTheme(backgroundColor: AppColor.secondary, foregroundColor: AppColor.third),
        ),
        debugShowCheckedModeBanner: false,
        home: const LoadingPage(),
      ),
    );
  }
}
