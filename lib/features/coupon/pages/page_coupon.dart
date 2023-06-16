import 'package:flutter/material.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/constants/const_typography.dart';
import 'package:google_map_new/models/model_place.dart';
import 'package:google_map_new/widgets/app_bar.dart';
import 'package:intl/intl.dart';

class CouponPage extends StatelessWidget {
  final PlaceModel placeItem;

  const CouponPage({super.key, required this.placeItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: AppSpace.third, horizontal: AppSpace.secondary),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Coupon', style: AppText.title),
          const SizedBox(height: AppSpace.secondary),
          Expanded(
            child: ListView.builder(
              itemCount: placeItem.couponList!.length,
              itemBuilder: (context, index) => Column(
                children: [
                  ListTile(
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/coupons/detail',
                      arguments: {'couponItem': placeItem.couponList![index]},
                    ),
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 10,
                    leading: Container(
                      constraints: const BoxConstraints(minWidth: 60, minHeight: 60),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppRounded.primary)),
                      child: Image.network(
                        'https://static.vecteezy.com/system/resources/thumbnails/002/331/963/small/20-percent-off-sale-tag-sale-of-special-offers-discount-with-the-price-is-20-percent-vector.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(placeItem.couponList![index].name, style: AppText.normalBold),
                    subtitle: Text(
                      'Expired in ${DateFormat('dd-MM-yyyy').format(DateTime.parse(placeItem.couponList![index].expired))}',
                      style: AppText.label.copyWith(color: AppColor.unActive),
                    ),
                  ),
                  if (index != placeItem.couponList!.length - 1) const Divider(color: AppColor.unActive, indent: 80),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
