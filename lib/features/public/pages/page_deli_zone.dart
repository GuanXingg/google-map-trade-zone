import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/models/model_distance.dart';
import 'package:google_map_new/models/model_place.dart';
import 'package:google_map_new/models/model_zone.dart';
import 'package:google_map_new/providers/provider_zone.dart';
import 'package:google_map_new/utils/current_location.dart';
import 'package:google_map_new/utils/custom_logger.dart';
import 'package:google_map_new/utils/get_bound_view.dart';
import 'package:google_map_new/widgets/app_bar.dart';
import 'package:google_map_new/widgets/custom_alert.dart';
import 'package:google_map_new/widgets/function_button.dart';
import 'package:google_map_new/widgets/markers.dart';
import 'package:google_map_new/widgets/polygons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../functions/deli_zone/get_min_zone.dart';
import '../functions/deli_zone/get_place_dis_zone.dart';
import '../functions/deli_zone/get_zone_point.dart';
import '../widgets/deli_zone/widget_dialog_place.dart';

class DeliZonePage extends StatefulWidget {
  const DeliZonePage({super.key});

  @override
  State<DeliZonePage> createState() => _DeliZonePageState();
}

class _DeliZonePageState extends State<DeliZonePage> {
  final Completer<GoogleMapController> kGgController = Completer<GoogleMapController>();

  String selectedPlace = '';
  bool hasCoupon = false;
  LatLng? initPos;
  Set<Marker> markers = {};
  Set<Polygon> polygons = {};
  List<ZoneModel> zoneData = [];
  List<PlaceModel> currentPlaceZone = [];
  List<PointDistanceModel> pointDisData = [];

  Future<void> _initLoadData() async {
    try {
      final LatLng currentPos = await getCurrentLocation();
      final Set<Marker> newMarkers = {};
      final Set<Polygon> newPolygons = {};
      final List<ZoneModel>? newZoneData = Provider.of<ZoneProvider>(context, listen: false).zoneData;
      bool newHasCoupon = false;
      List<PlaceModel> newCurrentPlaceZone = [];

      // Check zone data in provider has null or not
      if (newZoneData == null) {
        CLog.error('An occurred while get zone data!!!');
        CAlert.error(
          context,
          content: 'Can not load data, try import zone file again',
          onConfirm: () => Navigator.popUntil(context, (route) => route.settings.name == '/delivery'),
        );
      }

      // Get min zone from current location
      final List<LatLng> allZonePos = await getAllZonePoint(newZoneData!);
      final int indexMinZone = getMinZone(currentPos, allZonePos, newZoneData);
      final List<PointDistanceModel> newPointDisData =
          sortPlaceDisZone(currentPos, newZoneData[indexMinZone].placeList);

      // Check has coupon or not
      for (PlaceModel el in newZoneData[indexMinZone].placeList)
        if (el.couponList!.isNotEmpty) {
          newHasCoupon = true;
          break;
        }

      // Get place in nearest zone
      newCurrentPlaceZone = newZoneData[indexMinZone].placeList;
      newCurrentPlaceZone.sort((a, b) {
        String nameA = a.name;
        String nameB = b.name;
        int indexA = newPointDisData.indexWhere((el) => el.name == nameA);
        int indexB = newPointDisData.indexWhere((el) => el.name == nameB);

        return indexA.compareTo(indexB);
      });

      // Draw in google map
      newMarkers.add(currentMarker(currentPos));
      for (int i = 0; i < newCurrentPlaceZone.length; i++) {
        if (i == 0)
          newMarkers.add(
            highlightMarker(
              'pos-${newCurrentPlaceZone[i].name}',
              newCurrentPlaceZone[i].point,
              newCurrentPlaceZone[i].name,
              highlightText: 'Suggest place',
              info: newCurrentPlaceZone[i].address,
              onTap: onTapMarkerPlace,
            ),
          );
        else
          newMarkers.add(
            customMarker(
              'pos-${newCurrentPlaceZone[i].name}',
              newCurrentPlaceZone[i].point,
              newCurrentPlaceZone[i].name,
              info: newCurrentPlaceZone[i].address,
              onTap: onTapMarkerPlace,
            ),
          );
      }
      newPolygons.add(customPolygon('poly-zone', newZoneData[indexMinZone].zone, newZoneData[indexMinZone].color));

      setState(() {
        initPos = currentPos;
        markers = newMarkers;
        polygons = newPolygons;
        zoneData = newZoneData;
        hasCoupon = newHasCoupon;
        pointDisData = newPointDisData;
        currentPlaceZone = newCurrentPlaceZone;
      });
    } catch (err) {
      CLog.error('An occurred while load delivery zone map!!!, log: $err');
      CAlert.error(
        context,
        content: 'Can not identify your location, please select again',
        onConfirm: () {
          Navigator.popUntil(context, (route) => route.settings.name == '/delivery');
        },
      );
    }
  }

  Future<void> handleCurrentLocation() async {
    try {
      final GoogleMapController controller = await kGgController.future;
      final LatLng currentPos = await getCurrentLocation();

      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: currentPos, zoom: 15)));
    } catch (err) {
      CLog.error('An occurred while load zone map!!!, log: $err');
      CAlert.error(context, content: 'Can not identify your location');
    }
  }

  Future<void> handleBoundView() async {
    try {
      final GoogleMapController controller = await kGgController.future;
      final LatLng currentPos = await getCurrentLocation();
      final List<LatLng> allZonePos = await getAllZonePoint(zoneData);
      final int indexMinZone = getMinZone(currentPos, allZonePos, zoneData);

      final LatLngBounds bounds = getBoundView(currentPos, zoneData[indexMinZone].zone);
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    } catch (err) {
      CLog.error('An occurred while load zone map!!!, log: $err');
      CAlert.error(context, content: 'Can not identify your location');
    }
  }

  void onTapMarkerPlace(String place) {
    setState(() => selectedPlace = place);
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
              GoogleMap(
                initialCameraPosition: CameraPosition(target: initPos!, zoom: 15),
                onMapCreated: (controller) => kGgController.complete(controller),
                markers: markers,
                polygons: polygons,
                onTap: (_) => setState(() => selectedPlace = ''),
                mapToolbarEnabled: false,
                zoomControlsEnabled: false,
              ),
              Positioned(
                top: AppSpace.secondary,
                right: AppSpace.third,
                child: FunctionButton(
                  icon: Icon(Icons.store, color: hasCoupon ? AppColor.highlight : AppColor.third),
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => DeliZoneDialogPlace(
                      selectedPlace: selectedPlace,
                      placeList: currentPlaceZone,
                      placeDisList: pointDisData,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                right: AppSpace.third,
                child: Column(children: [
                  if (selectedPlace.isNotEmpty)
                    FunctionButton(
                      icon: const Icon(Icons.directions, color: AppColor.secondary),
                      bgColor: AppColor.primary,
                      onTap: () => Navigator.pushNamed(context, '/user/form'),
                    ),
                  const SizedBox(height: AppSpace.secondary),
                  FunctionButton(icon: const Icon(Icons.map, color: AppColor.third), onTap: handleBoundView),
                  const SizedBox(height: AppSpace.secondary),
                  FunctionButton(icon: const Icon(Icons.location_searching), onTap: handleCurrentLocation),
                ]),
              ),
            ]),
    );
  }
}
