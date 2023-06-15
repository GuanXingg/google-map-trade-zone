import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationProvider extends ChangeNotifier {
  String? _selectedLocation;
  int? _selectedType;

  String? get selectedLocation => _selectedLocation;
  int? get selectedType => _selectedType;

  Future<void> loadLocation() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();

    final String? encodeLocation = shared.getString('locationData');
    final String? encodeType = shared.getString('locationType');

    if (encodeLocation == null || encodeType == null) return;
    final String location = jsonDecode(encodeLocation);
    final int type = jsonDecode(encodeType);

    _selectedLocation = location;
    _selectedType = type;

    notifyListeners();
  }

  Future<void> updateLocation(String location, int type) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();

    _selectedLocation = location;
    _selectedType = type;

    final String encodeLocation = jsonEncode(location);
    final String encodeLocationType = jsonEncode(type);

    shared.setString('locationData', encodeLocation);
    shared.setString('locationType', encodeLocationType);

    notifyListeners();
  }

  Future<void> clearLocation() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();

    _selectedLocation = null;
    _selectedType = null;

    shared.remove('locationData');
    shared.remove('locationType');

    notifyListeners();
  }
}
