import 'package:flutter/material.dart';
import 'package:google_map_new/widgets/app_bar.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        leading: IconButton(
          onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/home')),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: const Center(child: Text('User form page')),
    );
  }
}
