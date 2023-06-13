import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/features/public/widgets/deli/widget_current_location.dart';
import 'package:google_map_new/utils/current_location.dart';
import 'package:google_map_new/utils/custom_logger.dart';
import 'package:google_map_new/widgets/app_bar.dart';
import 'package:google_map_new/widgets/custom_alert.dart';
import 'package:google_map_new/widgets/markers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/deli/widget_detail_location.dart';
import '../widgets/deli/widget_map.dart';
import '../widgets/deli/widget_search.dart';

class DeliPage extends StatefulWidget {
  const DeliPage({super.key});

  @override
  State<DeliPage> createState() => _DeliPageState();
}

class _DeliPageState extends State<DeliPage> {
  final Completer<GoogleMapController> kGgController = Completer<GoogleMapController>();
  final TextEditingController searchController = TextEditingController();

  LatLng? initPos;
  Set<Marker> markers = {};

  Future<void> _initLoadData() async {
    try {
      final LatLng currentPos = await getCurrentLocation();
      final Set<Marker> newMarkers = {};

      newMarkers.add(currentMarker(currentPos));

      setState(() {
        initPos = currentPos;
        markers = newMarkers;
      });
    } catch (err) {
      CLog.error('An occurred while load delivery map!!!, log: $err');
      CAlert.error(context, content: 'Can not identify your location');

      setState(() => initPos = const LatLng(0, 0));
    }
  }

  Future<void> handleCurrentLocation() async {
    markers.clear();
    try {
      final GoogleMapController controller = await kGgController.future;
      final LatLng currentPos = await getCurrentLocation();
      final Set<Marker> newMarkers = {};

      newMarkers.add(currentMarker(currentPos));
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: currentPos, zoom: 15)));

      setState(() => markers = newMarkers);
    } catch (err) {
      CLog.error('An occurred while load delivery map!!!, log: $err');
      CAlert.error(context, content: 'Can not identify your location');
    }
  }

  @override
  void initState() {
    super.initState();
    _initLoadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: (initPos == null)
          ? const SpinKitDoubleBounce(color: AppColor.highlight)
          : Stack(children: [
              DeliGoogleMap(mapController: kGgController, markers: markers, initPos: initPos),
              const DeliSearchField(),
              const DeliDetailLocation(),
              DeliCurrentLocation(onTap: handleCurrentLocation),
            ]),
    );
  }
}
