import 'package:flutter/material.dart';
import 'package:google_map_new/widgets/app_bar.dart';

class PickupPage extends StatelessWidget {
  const PickupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
    );
  }
}
