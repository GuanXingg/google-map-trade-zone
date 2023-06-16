import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryZoneMap extends StatelessWidget {
  final LatLng? initPos;
  final Set<Marker> markers;
  final Set<Polygon> polygons;
  final Completer<GoogleMapController> kGgController;
  final void Function() onTap;

  const DeliveryZoneMap({
    super.key,
    this.initPos,
    required this.markers,
    required this.polygons,
    required this.kGgController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: initPos!, zoom: 15),
      onMapCreated: (controller) => kGgController.complete(controller),
      markers: markers,
      polygons: polygons,
      onTap: (_) => onTap(),
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
    );
  }
}
