import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/constants/const_typography.dart';
import 'package:google_map_new/models/model_zone.dart';
import 'package:google_map_new/providers/provider_location.dart';
import 'package:google_map_new/providers/provider_zone.dart';
import 'package:google_map_new/widgets/custom_alert.dart';
import 'package:provider/provider.dart';

import '../widgets/home/widget_card_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Image> imgUrls = [
    Image.asset('assets/images/slideshow-1.jpg', fit: BoxFit.cover),
    Image.asset('assets/images/slideshow-2.jpg', fit: BoxFit.cover),
    Image.asset('assets/images/slideshow-3.jpg', fit: BoxFit.cover),
    Image.asset('assets/images/slideshow-4.jpg', fit: BoxFit.cover),
  ];

  void _initLoadData() {
    Provider.of<ZoneProvider>(context, listen: false).loadZoneInStorage();
    Provider.of<LocationProvider>(context, listen: false).loadLocation();
  }

  void handleNavigateDeliPage() {
    final List<ZoneModel>? zoneData = Provider.of<ZoneProvider>(context, listen: false).zoneData;
    if (zoneData == null)
      CAlert.error(context, content: 'You must import zone file first');
    else
      Navigator.pushNamed(context, '/delivery');
  }

  void handleNavigatePickupPage() {
    final List<ZoneModel>? zoneData = Provider.of<ZoneProvider>(context, listen: false).zoneData;
    if (zoneData == null)
      CAlert.error(context, content: 'You must import zone file first');
    else
      Navigator.pushNamed(context, '/pickup');
  }

  @override
  void initState() {
    super.initState();
    _initLoadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo-symbol.png', width: 120),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            icon: const Icon(Icons.settings, color: AppColor.unActive),
          )
        ],
      ),
      body: Consumer<LocationProvider>(
        builder: (_, value, __) => Column(children: [
          CarouselSlider(items: imgUrls, options: CarouselOptions(autoPlay: true, height: 200)),
          const SizedBox(height: AppSpace.third),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.secondary),
            width: AppSpace.infinite,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Welcome, Hưng', style: AppText.heading),
              const SizedBox(height: AppSpace.minimum),
              Text('Please select the transport you want', style: AppText.label.copyWith(color: AppColor.unActive)),
              const SizedBox(height: AppSpace.secondary),
              Column(children: [
                HomeCardItem(
                  title: 'Delivery',
                  subtitle: 'Let me know your location',
                  currentLocation:
                      (value.selectedType != null && value.selectedType == 0) ? value.selectedLocation : null,
                  icon: Icons.local_shipping,
                  onTap: handleNavigateDeliPage,
                ),
                HomeCardItem(
                  title: 'Pick up',
                  subtitle: 'Find the nearest store',
                  currentLocation:
                      (value.selectedType != null && value.selectedType == 1) ? value.selectedLocation : null,
                  icon: Icons.fastfood,
                  onTap: handleNavigatePickupPage,
                ),
              ]),
            ]),
          )
        ]),
      ),
    );
  }
}
