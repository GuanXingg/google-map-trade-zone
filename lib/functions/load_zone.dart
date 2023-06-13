import 'package:google_map_new/models/model_coupon.dart';
import 'package:google_map_new/models/model_place.dart';
import 'package:google_map_new/models/model_zone.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<ZoneModel> loadZoneData(List<dynamic> json) {
  final List<ZoneModel> zoneData = [];

  for (dynamic el in json) {
    final String zoneName = el['name'];
    final String zoneColor = el['color'];
    final List<LatLng> zoneZone =
        (el['zone'] as List).map((zoneZoneEl) => LatLng(zoneZoneEl[0], zoneZoneEl[1])).toList();

    final List<PlaceModel> placeList = [];
    for (dynamic placeEl in el['placeList']) {
      final String placeName = placeEl['name'];
      final String placeAddress = placeEl['address'];
      final String placeOpenTime = placeEl['openTime'];
      final String placeCloseTime = placeEl['closeTime'];
      final LatLng placePoint = LatLng(placeEl['point'][0], placeEl['point'][1]);

      final List<CouponModel> couponList = [];
      if ((placeEl['couponList'] as List).isNotEmpty) {
        for (dynamic couponEl in placeEl['couponList']) {
          final int couponId = couponEl['id'];
          final String couponName = couponEl['name'];
          final String couponDesc = couponEl['description'];
          final String couponExpired = couponEl['expired'];
          final String couponPlace = couponEl['place'];

          final Map<String, dynamic> couponItem = {
            'id': couponId,
            'name': couponName,
            'description': couponDesc,
            'expired': couponExpired,
            'place': couponPlace,
          };

          couponList.add(CouponModel.fromJson(couponItem));
        }
      }

      final Map<String, dynamic> placeItem = {
        'name': placeName,
        'address': placeAddress,
        'openTime': placeOpenTime,
        'closeTime': placeCloseTime,
        'point': placePoint,
        'couponList': couponList,
      };

      placeList.add(PlaceModel.fromJson(placeItem));
    }

    final Map<String, dynamic> zoneItem = {
      'name': zoneName,
      'color': zoneColor,
      'zone': zoneZone,
      'placeList': placeList,
    };

    zoneData.add(ZoneModel.fromJson(zoneItem));
  }

  return zoneData;
}
