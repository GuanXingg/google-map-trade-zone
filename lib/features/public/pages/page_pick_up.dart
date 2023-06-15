import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/constants/const_typography.dart';
import 'package:google_map_new/models/model_distance.dart';
import 'package:google_map_new/models/model_place.dart';
import 'package:google_map_new/models/model_zone.dart';
import 'package:google_map_new/providers/provider_zone.dart';
import 'package:google_map_new/utils/current_location.dart';
import 'package:google_map_new/utils/custom_logger.dart';
import 'package:google_map_new/widgets/app_bar.dart';
import 'package:google_map_new/widgets/custom_alert.dart';
import 'package:google_map_new/widgets/markers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../functions/pick_up/get_all_place.dart';
import '../functions/pick_up/get_place_dis_zone.dart';
import '../widgets/pick_up/widget_info.dart';
import '../widgets/pick_up/widget_list_place.dart';

class PickupPage extends StatefulWidget {
  const PickupPage({super.key});

  @override
  State<PickupPage> createState() => _PickupPageState();
}

class _PickupPageState extends State<PickupPage> {
  final Completer<GoogleMapController> kGgController = Completer<GoogleMapController>();

  int placeSelected = 0;
  Set<Marker> markers = {};
  List<PointDistanceModel> placeDisData = [];
  List<PlaceModel> placeData = [];

  Future<void> _initLoadData() async {
    final LatLng currentPos = await getCurrentLocation();

    final Set<Marker> newMarkers = {};
    final List<ZoneModel> newZoneData = Provider.of<ZoneProvider>(context, listen: false).zoneData!;
    final List<PlaceModel> newPlaceData = getAllPlace(newZoneData);
    final List<PointDistanceModel> newPlaceDisData = sortPlaceDisZone(currentPos, newPlaceData);

    newPlaceData.sort((a, b) {
      String nameA = a.name;
      String nameB = b.name;
      int indexA = newPlaceDisData.indexWhere((el) => el.name == nameA);
      int indexB = newPlaceDisData.indexWhere((el) => el.name == nameB);

      return indexA.compareTo(indexB);
    });

    newMarkers.add(customMarker('pos-current-select', newPlaceData.first.point, newPlaceData.first.name));

    setState(() {
      placeData = newPlaceData;
      placeDisData = newPlaceDisData;
      markers = newMarkers;
    });
  }

  Future<void> handleSelectedPlace(int index) async {
    markers.clear();
    try {
      final GoogleMapController controller = await kGgController.future;
      final Set<Marker> newMarkers = {};

      newMarkers.add(customMarker('pos-current-place', placeData[index].point, placeData[index].name));

      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: placeData[index].point,
        zoom: 15,
      )));

      setState(() {
        placeSelected = index;
        markers = newMarkers;
      });
    } catch (err) {
      CLog.error('An occurred while selected place!!!, log: $err');
      CAlert.error(context, content: 'Something went wrong, please try again');
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
      body: (placeData.isEmpty && placeDisData.isEmpty)
          ? const SpinKitDoubleBounce(color: AppColor.highlight)
          : Stack(children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(target: placeData.first.point, zoom: 15),
                onMapCreated: (controller) => kGgController.complete(controller),
                markers: markers,
                mapToolbarEnabled: false,
                zoomControlsEnabled: false,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  constraints: const BoxConstraints(minHeight: 200),
                  padding: const EdgeInsets.all(AppSpace.secondary),
                  decoration: BoxDecoration(
                    color: AppColor.secondary,
                    borderRadius: BorderRadius.circular(AppRounded.primary),
                    boxShadow: const [BoxShadow(color: AppColor.unActive, blurRadius: 5, offset: Offset(0, -1))],
                  ),
                  child: Column(children: [
                    const Text('Select pick up store', style: AppText.headingSmall),
                    const SizedBox(height: AppSpace.minimum),
                    PickupInfo(
                      indexSelected: placeSelected,
                      placeData: placeData,
                      handleSelectedPlace: handleSelectedPlace,
                      placeDisData: placeDisData,
                    ),
                    const SizedBox(height: AppSpace.secondary),
                    PickupListPlace(
                      indexSelected: placeSelected,
                      placeData: placeData,
                      placeDisData: placeDisData,
                      onPageChanged: handleSelectedPlace,
                    ),
                  ]),
                ),
              ),
            ]),
    );
  }
}
