import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliMap extends StatelessWidget {
  final Completer<GoogleMapController> mapController;
  final LatLng? initPos;
  final Set<Marker> markers;

  const DeliMap({
    super.key,
    required this.mapController,
    required this.markers,
    this.initPos,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: initPos!, zoom: 15),
      onMapCreated: (controller) => mapController.complete(controller),
      markers: markers,
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
    );
  }
}
