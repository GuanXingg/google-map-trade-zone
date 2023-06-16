import 'package:google_maps_flutter/google_maps_flutter.dart';

Marker currentMarker(LatLng pos, {void Function()? onTap}) =>
    Marker(markerId: const MarkerId('pos-current'), position: pos, onTap: onTap);

Marker customMarker(
  LatLng pos,
  String place, {
  String? info,
  void Function(String)? onTap,
}) =>
    Marker(
      markerId: MarkerId('pos-$place'),
      position: pos,
      infoWindow: InfoWindow(title: place, snippet: info),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      onTap: (onTap == null) ? null : () => onTap(place),
    );

Marker highlightMarker(
  LatLng pos,
  String place, {
  String? info,
  String? highlightText,
  void Function(String)? onTap,
}) =>
    Marker(
      markerId: MarkerId('pos-$place'),
      position: pos,
      infoWindow: InfoWindow(title: (highlightText == null) ? place : '$place ($highlightText)', snippet: info),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      onTap: (onTap == null) ? null : () => onTap(place),
    );
