import 'package:flutter/material.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/constants/const_typography.dart';
import 'package:google_map_new/models/model_zone.dart';
import 'package:google_map_new/providers/provider_zone.dart';
import 'package:google_map_new/widgets/custom_alert.dart';
import 'package:provider/provider.dart';

class HomeCardItem extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String subtitle;
  final int indexNavigate;
  final IconData icon;
  final String? currentLocation;

  const HomeCardItem({
    super.key,
    required this.context,
    required this.title,
    required this.subtitle,
    required this.indexNavigate,
    required this.icon,
    this.currentLocation,
  });

  void handleNavigatePage(int index) {
    final List<ZoneModel>? zoneData = Provider.of<ZoneProvider>(context, listen: false).zoneData;
    if (zoneData == null)
      CAlert.error(context, content: 'You must import zone file first');
    else {
      if (index == 0)
        Navigator.pushNamed(context, '/delivery');
      else
        Navigator.pushNamed(context, '/pickup');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(top: AppSpace.minimum),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRounded.minimum)),
      child: InkWell(
        onTap: () => handleNavigatePage(indexNavigate),
        child: ListTile(
          horizontalTitleGap: 10,
          leading: Icon(icon, size: AppIconSize.maximum, color: AppColor.primary),
          trailing: (currentLocation == null)
              ? const Icon(Icons.chevron_right, color: AppColor.primary)
              : const Text('Change', style: TextStyle(color: AppColor.primary)),
          title: Text(title, style: AppText.normalBold),
          subtitle: Text(
            (currentLocation == null) ? subtitle : currentLocation!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.label.copyWith(color: AppColor.unActive),
          ),
        ),
      ),
    );
  }
}
