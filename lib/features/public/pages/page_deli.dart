import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliPage extends StatefulWidget {
  const DeliPage({super.key});

  @override
  State<DeliPage> createState() => _DeliPageState();
}

class _DeliPageState extends State<DeliPage> {
  final Completer<GoogleMapController> kGgController = Completer<GoogleMapController>();
  final Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo-symbol.png', width: 120),
        centerTitle: true,
      ),
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition: const CameraPosition(target: LatLng(0, 0), zoom: 15),
          markers: markers,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
        ),
      ]),
    );
  }
}
