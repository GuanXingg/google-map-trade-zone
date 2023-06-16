import 'package:flutter/material.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/constants/const_typography.dart';
import 'package:google_map_new/models/model_coupon.dart';
import 'package:google_map_new/widgets/app_bar.dart';
import 'package:intl/intl.dart';

class CouponDetailPage extends StatelessWidget {
  final CouponModel couponItem;

  const CouponDetailPage({super.key, required this.couponItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Column(children: [
        SizedBox(
          width: AppSpace.infinite,
          height: 200,
          child: Image.network(
            'https://static.vecteezy.com/system/resources/thumbnails/002/331/963/small/20-percent-off-sale-tag-sale-of-special-offers-discount-with-the-price-is-20-percent-vector.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: SafeArea(
              minimum: const EdgeInsets.symmetric(vertical: AppSpace.third, horizontal: AppSpace.secondary),
              child: Column(children: [
                Text(couponItem.name, style: AppText.title),
                const SizedBox(height: AppSpace.minimum),
                Text(
                  'Expired in ${DateFormat('dd-MM-yyyy').format(DateTime.parse(couponItem.expired))}',
                  style: AppText.label.copyWith(color: AppColor.unActive),
                ),
                const SizedBox(height: AppSpace.secondary),
                Text(couponItem.description, textAlign: TextAlign.justify),
              ]),
            ),
          ),
        ),
        Container(
          constraints: const BoxConstraints(minWidth: AppSpace.infinite, minHeight: 80),
          padding: const EdgeInsets.all(AppSpace.secondary),
          decoration: const BoxDecoration(
            color: AppColor.secondary,
            boxShadow: [BoxShadow(color: AppColor.unActive, blurRadius: 10, offset: Offset(0, -1))],
          ),
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/user/form'),
            child: const Text('Apply and order'),
          ),
        )
      ]),
    );
  }
}
