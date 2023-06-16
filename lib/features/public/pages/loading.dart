import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 4)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            Future.delayed(
              const Duration(seconds: 1, milliseconds: 500),
              () => Navigator.pushReplacementNamed(context, '/home'),
            );

          return Center(child: Image.asset('assets/images/logo.png', width: 150));
        },
      ),
    );
  }
}
