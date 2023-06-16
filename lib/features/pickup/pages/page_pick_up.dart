import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/constants/const_typography.dart';
import 'package:google_map_new/models/model_distance.dart';
import 'package:google_map_new/models/model_place.dart';
import 'package:google_map_new/models/model_zone.dart';
import 'package:google_map_new/providers/provider_location.dart';
import 'package:google_map_new/providers/provider_zone.dart';
import 'package:google_map_new/utils/current_location.dart';
import 'package:google_map_new/utils/custom_logger.dart';
import 'package:google_map_new/widgets/app_bar.dart';
import 'package:google_map_new/widgets/custom_alert.dart';
import 'package:google_map_new/widgets/function_button.dart';
import 'package:google_map_new/widgets/markers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../functions/pick_up/get_all_place.dart';
import '../functions/pick_up/get_place_dis_zone.dart';
import '../widgets/pick_up/widget_info.dart';
import '../widgets/pick_up/widget_carousel_place.dart';

class PickupPage extends StatefulWidget {
  const PickupPage({super.key});

  @override
  State<PickupPage> createState() => _PickupPageState();
}

class _PickupPageState extends State<PickupPage> {
  final Completer<GoogleMapController> kGgController = Completer<GoogleMapController>();
  final CarouselController kCarouselController = CarouselController();
  final Set<Marker> markers = {};

  int placeSelected = 0;
  List<PointDistanceModel> placeDisData = [];
  List<PlaceModel> placeData = [];

  Future<void> _initLoadData() async {
    final LatLng currentPos = await getCurrentLocation();

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

    markers.add(customMarker(newPlaceData.first.point, newPlaceData.first.name));

    setState(() {
      placeData = newPlaceData;
      placeDisData = newPlaceDisData;
    });
  }

  Future<void> handleSelectedPlace(int index) async {
    markers.clear();
    try {
      final GoogleMapController controller = await kGgController.future;

      markers.add(customMarker(placeData[index].point, placeData[index].name));
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: placeData[index].point,
        zoom: 15,
      )));

      kCarouselController.jumpToPage(index);

      setState(() => placeSelected = index);
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
              if (placeData[placeSelected].couponList != null && placeData[placeSelected].couponList!.isNotEmpty)
                Positioned(
                  top: AppSpace.third,
                  right: AppSpace.secondary,
                  child: FunctionButton(
                    icon: Icon(Icons.store, color: AppColor.active),
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/coupons',
                      arguments: {'placeItem': placeData[placeSelected]},
                    ),
                  ),
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
                    PickupCarouselPlace(
                      carouselController: kCarouselController,
                      indexSelected: placeSelected,
                      placeData: placeData,
                      placeDisData: placeDisData,
                      onPageChanged: handleSelectedPlace,
                    ),
                    const SizedBox(height: AppSpace.secondary),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<LocationProvider>(context, listen: false)
                            .updateLocation(placeData[placeSelected].address, 1);
                        Navigator.pushNamed(context, '/user/form');
                      },
                      style: const ButtonStyle(minimumSize: MaterialStatePropertyAll(Size.fromHeight(45))),
                      child: const Text('Apply and order'),
                    ),
                  ]),
                ),
              ),
            ]),
    );
  }
}
