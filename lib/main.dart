import 'package:flutter/material.dart';

import './constants/const_color.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Map',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: AppBaseColor.primary,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.secondary,
          foregroundColor: AppColor.third,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(child: Text('Hello World!')),
      ),
    );
  }
}
