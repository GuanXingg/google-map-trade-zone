import 'package:flutter/material.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/constants/const_typography.dart';
import 'package:google_map_new/models/model_distance.dart';
import 'package:google_map_new/models/model_place.dart';
import 'package:google_map_new/widgets/custom_alert.dart';

class DeliZoneDialogPlace extends StatelessWidget {
  final String selectedPlace;
  final List<PlaceModel> placeList;
  final List<PointDistanceModel> placeDisList;

  const DeliZoneDialogPlace(
      {super.key, required this.selectedPlace, required this.placeList, required this.placeDisList});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpace.third),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Row(children: [
            Icon(Icons.store, size: AppIconSize.secondary, color: AppColor.third),
            SizedBox(width: AppSpace.minimum),
            Text('Select your favorite store', style: AppText.normalBold),
          ]),
          const SizedBox(height: AppSpace.secondary),
          Expanded(
            child: ListView.builder(
              itemCount: placeList.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(top: AppSpace.minimum),
                padding: const EdgeInsets.symmetric(vertical: AppSpace.primary),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: (selectedPlace == placeList[index].name) ? AppColor.active : AppColor.unActive,
                  ),
                  borderRadius: BorderRadius.circular(AppRounded.minimum),
                ),
                child: InkWell(
                  onTap: (placeList[index].couponList == null || placeList[index].couponList!.isEmpty)
                      ? () => CAlert.info(context, content: 'This place has no coupon')
                      : () => Navigator.pushNamed(context, '/coupons', arguments: {'placeItem': placeList[index]}),
                  child: ListTile(
                    horizontalTitleGap: 10,
                    leading: CircleAvatar(
                      backgroundColor: AppColor.unActive.withOpacity(0.3),
                      radius: 15,
                      child: Icon(
                        Icons.location_on,
                        size: AppIconSize.primary,
                        color: (placeList[index].couponList!.isEmpty) ? AppColor.third : AppColor.active,
                      ),
                    ),
                    title: Text(placeList[index].name, style: AppText.normalBold),
                    subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const SizedBox(height: 5),
                      Text(
                        '${placeList[index].openTime} : ${placeList[index].closeTime}',
                        style: AppText.label.copyWith(color: AppColor.active),
                      ),
                      Text(placeList[index].address, style: AppText.label),
                      Text(placeDisList[index].description, style: AppText.label),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
