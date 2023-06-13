import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:google_map_new/models/model_coupon.dart';

Future<List<dynamic>> getRawCouponData() async {
  const String couponFile = 'assets/data/fake_coupon.json';

  try {
    final String jsonString = await rootBundle.loadString(couponFile);
    final Map<String, dynamic> json = jsonDecode(jsonString);
    final List<dynamic> jsonCoupon = json['coupons'];

    return jsonCoupon;
  } catch (err) {
    return Future.error('Can not load coupon json file in root project');
  }
}

Future<List<CouponModel>> getCouponData() async {
  final List<CouponModel> couponData = [];
  final List<dynamic> jsonCoupon = await getRawCouponData();

  for (dynamic el in jsonCoupon) {
    final int id = el['id'];
    final String name = el['name'].trim();
    final String description = el['description'].trim();
    final String expired = el['expired'].trim();
    final String place = el['place'].trim();

    final Map<String, dynamic> item = {
      'id': id,
      'name': name,
      'description': description,
      'expired': expired,
      'place': place,
    };

    couponData.add(CouponModel.fromJson(item));
  }

  return couponData;
}
