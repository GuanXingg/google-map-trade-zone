import 'package:flutter/material.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/constants/const_typography.dart';
import 'package:google_map_new/models/model_distance.dart';
import 'package:google_map_new/models/model_place.dart';

class PickupInfo extends StatelessWidget {
  final int indexSelected;
  final List<PlaceModel> placeData;
  final List<PointDistanceModel> placeDisData;
  final void Function(int) handleSelectedPlace;

  const PickupInfo({
    super.key,
    required this.indexSelected,
    required this.placeData,
    required this.placeDisData,
    required this.handleSelectedPlace,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        child: Text(
          placeData[indexSelected].address,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppText.normal.copyWith(color: AppColor.unActive),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: AppSpace.primary),
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, '/pickup/all', arguments: {
            'indexSelected': indexSelected,
            'placeData': placeData,
            'placeDisData': placeDisData,
            'onTap': handleSelectedPlace,
          }),
          child: const Text('See all', style: TextStyle(color: AppColor.highlight)),
        ),
      ),
    ]);
  }
}
