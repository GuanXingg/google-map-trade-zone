import 'package:google_map_new/models/model_coupon.dart';
import 'package:google_map_new/models/model_place.dart';
import 'package:google_map_new/utils/custom_logger.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<PlaceModel> getPlaceData(List<dynamic> rawPlace, List<CouponModel> couponData) {
  final List<PlaceModel> placeData = [];

  for (dynamic el in rawPlace) {
    final List<CouponModel> couponList = [];

    final String rawName = el['name'];
    final String rawDes = el['description'];
    final String rawPoint = el['Point']['coordinates'];

    final List<String> splitDes = rawDes.trim().split(',');
    final List<String> splitPoint = rawPoint.trim().split(',');

    final String name = rawName.trim();
    final String address = splitDes[0];
    final String openTime = splitDes[1];
    final String closeTime = splitDes[2];
    final LatLng point = LatLng(double.parse(splitPoint[1]), double.parse(splitPoint[0]));

    for (CouponModel couponEl in couponData) {
      if (name == couponEl.place) couponList.add(couponEl);
    }

    final Map<String, dynamic> item = {
      'name': name,
      'address': address,
      'openTime': openTime,
      'closeTime': closeTime,
      'point': point,
      'couponList': couponList,
    };

    placeData.add(PlaceModel.fromJson(item));
  }

  return placeData;
}
