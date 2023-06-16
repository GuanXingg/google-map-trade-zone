import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/models/model_coupon.dart';
import 'package:google_map_new/models/model_place.dart';
import 'package:google_map_new/models/model_zone.dart';
import 'package:google_map_new/providers/provider_zone.dart';
import 'package:google_map_new/utils/custom_logger.dart';
import 'package:google_map_new/widgets/app_bar.dart';
import 'package:google_map_new/widgets/custom_alert.dart';
import 'package:provider/provider.dart';

import '../functions/setting/get_coupon.dart';
import '../functions/setting/get_place.dart';
import '../functions/setting/get_raw_placemark.dart';
import '../functions/setting/get_zone.dart';
import '../widgets/setting/widget_list_item.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Future<void> handleImportFile() async {
    try {
      final List<dynamic> rawZoneData = await getRawZoneData();
      final List<dynamic> rawPlaceData = await getRawPlaceData();

      final List<CouponModel> couponData = await getCouponData();
      final List<PlaceModel> placeData = getPlaceData(rawPlaceData, couponData);
      final List<ZoneModel> zoneData = getZoneData(rawZoneData, placeData);

      Provider.of<ZoneProvider>(context, listen: false).updateZoneData(zoneData);
      CAlert.success(
        context,
        content: 'Add file successful',
        onConfirm: () => Navigator.popUntil(context, ModalRoute.withName('/home')),
      );
    } catch (err) {
      CLog.error('An occurred while import file!!!, log: $err');
      CAlert.error(context, content: 'Could not import trade zone data');
    }
  }

  void handleDeleteFile() {
    Provider.of<ZoneProvider>(context, listen: false).clearZoneData();

    CAlert.success(
      context,
      content: 'Remove file successful',
      onConfirm: () => Navigator.popUntil(context, ModalRoute.withName('/home')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: AppSpace.third),
        child: Column(children: [
          SettingListItem(
            title: 'Import zone file',
            icon: Icons.download,
            bgColor: AppColor.highlight,
            onTap: handleImportFile,
          ),
          SettingListItem(title: 'Delete zone file', icon: Icons.delete, onTap: handleDeleteFile),
        ]),
      ),
    );
  }
}
