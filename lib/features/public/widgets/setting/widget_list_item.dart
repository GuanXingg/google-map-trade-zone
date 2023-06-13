import 'package:flutter/material.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/constants/const_typography.dart';

class SettingListItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bgColor;
  final void Function()? onTap;

  const SettingListItem({
    super.key,
    required this.title,
    required this.icon,
    this.bgColor = AppColor.primary,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSpace.infinite,
      padding: const EdgeInsets.symmetric(vertical: AppSpace.primary),
      decoration: const BoxDecoration(
        color: AppColor.secondary,
        border: Border(bottom: BorderSide(color: AppColor.unActive, width: 1)),
      ),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          horizontalTitleGap: 10,
          leading: CircleAvatar(
            backgroundColor: bgColor,
            child: Icon(icon, color: AppColor.secondary),
          ),
          title: Text(title, style: AppText.normalBold),
        ),
      ),
    );
  }
}
