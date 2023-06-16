import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/constants/const_typography.dart';
import 'package:google_map_new/models/model_distance.dart';
import 'package:google_map_new/models/model_place.dart';

class PickupCarouselPlace extends StatelessWidget {
  final CarouselController carouselController;
  final int indexSelected;
  final List<PlaceModel> placeData;
  final List<PointDistanceModel> placeDisData;
  final void Function(int) onPageChanged;

  const PickupCarouselPlace({
    super.key,
    required this.carouselController,
    required this.indexSelected,
    required this.placeData,
    required this.placeDisData,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: CarouselSlider(
        carouselController: carouselController,
        options: CarouselOptions(
          enableInfiniteScroll: false,
          viewportFraction: 0.7,
          aspectRatio: 25 / 9,
          enlargeCenterPage: true,
          onPageChanged: (index, _) => onPageChanged(index),
        ),
        items: placeData.asMap().entries.map((e) {
          final index = e.key;
          final item = e.value;

          return Builder(
            builder: (_) => Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.primary, vertical: AppSpace.minimum),
              width: AppSpace.infinite,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: (indexSelected == index) ? AppColor.highlight : AppColor.unActive),
                borderRadius: BorderRadius.circular(AppRounded.minimum),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(item.name, style: AppText.normalBold),
                const SizedBox(height: 5),
                Text('${item.openTime}:${item.closeTime}', style: AppText.label.copyWith(color: AppColor.active)),
                Text(
                  item.address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.label.copyWith(color: AppColor.unActive),
                ),
                Text(placeDisData[index].description, style: AppText.label.copyWith(color: AppColor.unActive)),
              ]),
            ),
          );
        }).toList(),
      ),
    );
  }
}
