import 'package:flutter/material.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/constants/const_typography.dart';
import 'package:google_map_new/models/model_distance.dart';
import 'package:google_map_new/models/model_place.dart';
import 'package:google_map_new/widgets/app_bar.dart';

class PickupPlaceAllPage extends StatelessWidget {
  final int indexSelected;
  final List<PlaceModel> placeData;
  final List<PointDistanceModel> placeDisData;
  final void Function(int) onTap;

  const PickupPlaceAllPage({
    super.key,
    required this.indexSelected,
    required this.placeData,
    required this.placeDisData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: AppSpace.third, horizontal: AppSpace.secondary),
        child: ListView.builder(
          itemCount: placeData.length,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.only(top: AppSpace.minimum),
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.primary, vertical: AppSpace.minimum),
            width: AppSpace.infinite,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: (indexSelected == index) ? AppColor.highlight : AppColor.unActive),
              borderRadius: BorderRadius.circular(AppRounded.minimum),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                onTap(index);
              },
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(placeData[index].name, style: AppText.normalBold),
                const SizedBox(height: 5),
                Text(
                  '${placeData[index].openTime}:${placeData[index].closeTime}',
                  style: AppText.label.copyWith(color: AppColor.active),
                ),
                Text(
                  placeData[index].address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.label.copyWith(color: AppColor.unActive),
                ),
                Text(placeDisData[index].description, style: AppText.label.copyWith(color: AppColor.unActive)),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
