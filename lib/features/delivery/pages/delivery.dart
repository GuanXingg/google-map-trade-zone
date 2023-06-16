import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/utils/current_location.dart';
import 'package:google_map_new/utils/custom_logger.dart';
import 'package:google_map_new/widgets/app_bar.dart';
import 'package:google_map_new/widgets/custom_alert.dart';
import 'package:google_map_new/widgets/function_button.dart';
import 'package:google_map_new/widgets/markers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/delivery/detail_location.dart';
import '../widgets/delivery/map.dart';
import '../widgets/delivery/search.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  final Completer<GoogleMapController> kGgController = Completer<GoogleMapController>();
  final TextEditingController searchController = TextEditingController();
  final Set<Marker> markers = {};

  LatLng? initPos;

  Future<void> _initLoadData() async {
    try {
      final LatLng currentPos = await getCurrentLocation();

      markers.add(currentMarker(currentPos));
      setState(() => initPos = currentPos);
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

      markers.add(currentMarker(currentPos));
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: currentPos, zoom: 15)));
    } catch (err) {
      CLog.error('An occurred while load delivery map!!!, log: $err');
      CAlert.error(context, content: 'Can not identify your location');
    }
  }

  void handleSubmitSearchPageValue() {
    Navigator.pop(context);
    setState(() {});
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
              DeliMap(mapController: kGgController, markers: markers, initPos: initPos),
              DeliSearch(searchController: searchController, handleSubmit: handleSubmitSearchPageValue),
              Positioned(
                bottom: 200,
                right: AppSpace.third,
                child: FunctionButton(icon: const Icon(Icons.location_searching), onTap: handleCurrentLocation),
              ),
              DeliDetailLocation(searchController: searchController),
            ]),
    );
  }
}
