import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:google_map_new/functions/load_zone.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/model_zone.dart';

class ZoneProvider extends ChangeNotifier {
  List<ZoneModel>? _zoneData;

  List<ZoneModel>? get zoneData => _zoneData;

  Future<void> loadZoneInStorage() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    final String? jsonString = shared.getString('zoneData');
    if (jsonString == null) {
      notifyListeners();
      return;
    }

    final List<dynamic> json = jsonDecode(jsonString);
    final List<ZoneModel> newZoneData = loadZoneData(json);
    _zoneData = newZoneData;

    notifyListeners();
  }

  Future<void> updateZoneData(List<ZoneModel> zoneData) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();

    _zoneData = zoneData;

    List<Map<String, dynamic>> json = zoneData.map((el) => el.toJson()).toList();
    String jsonStringZoneData = jsonEncode(json);
    shared.setString('zoneData', jsonStringZoneData);

    notifyListeners();
  }

  Future<void> clearZoneData() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();

    _zoneData = null;
    shared.remove('zoneData');

    notifyListeners();
  }
}
