import 'package:flutter/material.dart';
import 'package:google_map_new/widgets/app_bar.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: const Center(child: Text('User form page')),
    );
  }
}
