import 'package:google_maps_flutter/google_maps_flutter.dart';

import './model_coupon.dart';

class PlaceModel {
  late String name;
  late String address;
  late String openTime;
  late String closeTime;
  late LatLng point;
  List<CouponModel>? couponList;

  PlaceModel({
    required this.name,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.point,
    this.couponList,
  });

  PlaceModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    openTime = json['openTime'];
    closeTime = json['closeTime'];
    point = json['point'];
    couponList = json['couponList'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'openTime': openTime,
        'closeTime': closeTime,
        'point': point,
        'couponList': (couponList != null) ? couponList!.map((el) => el.toJson()).toList() : null,
      };
}
