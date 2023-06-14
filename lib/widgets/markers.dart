import 'package:google_maps_flutter/google_maps_flutter.dart';

Marker currentMarker(LatLng pos, {void Function()? onTap}) =>
    Marker(markerId: const MarkerId('pos-current'), position: pos, onTap: onTap);

Marker customMarker(
  String id,
  LatLng pos,
  String place, {
  String? info,
  void Function(String)? onTap,
}) =>
    Marker(
      markerId: MarkerId(id),
      position: pos,
      infoWindow: InfoWindow(title: place, snippet: info),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      onTap: (onTap == null) ? null : () => onTap(place),
    );

Marker highlightMarker(
  String id,
  LatLng pos,
  String place, {
  String? info,
  String? highlightText,
  void Function(String)? onTap,
}) =>
    Marker(
      markerId: MarkerId(id),
      position: pos,
      infoWindow: InfoWindow(title: '$place ${(highlightText == null) ? '' : '($highlightText)'}', snippet: info),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      onTap: (onTap == null) ? null : () => onTap(place),
    );
