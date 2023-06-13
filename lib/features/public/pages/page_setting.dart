import 'package:flutter/material.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/constants/const_typography.dart';
import 'package:google_map_new/features/public/widgets/setting/widget_list_item.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo-symbol.png', width: 120),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpace.third),
        child: Column(children: [
          SettingListItem(title: 'Import zone file', icon: Icons.download, bgColor: AppColor.highlight),
          SettingListItem(title: 'Delete zone file', icon: Icons.delete),
        ]),
      ),
    );
  }
}
