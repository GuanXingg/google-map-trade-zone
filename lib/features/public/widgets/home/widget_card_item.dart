import 'package:flutter/material.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/constants/const_typography.dart';

class HomeCardItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String? currentLocation;
  final void Function()? onTap;

  const HomeCardItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.currentLocation,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: AppSpace.minimum),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRounded.minimum)),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          horizontalTitleGap: 10,
          leading: Icon(icon, size: AppIconSize.maximum, color: AppColor.primary),
          trailing: (currentLocation == null)
              ? const Icon(Icons.chevron_right, color: AppColor.primary)
              : const Text('Change', style: TextStyle(color: AppColor.primary)),
          title: Text(title, style: AppText.normalBold),
          subtitle: Text(
            (currentLocation == null) ? 'Let me know your location' : currentLocation!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.label.copyWith(color: AppColor.unActive),
          ),
        ),
      ),
    );
  }
}
