import 'package:flutter/material.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/constants/const_typography.dart';
import 'package:google_map_new/providers/provider_location.dart';
import 'package:provider/provider.dart';

class DeliDetailLocation extends StatelessWidget {
  final TextEditingController searchController;

  const DeliDetailLocation({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    final String location =
        (searchController.text.isEmpty) ? '22 Hoàng Diệu, Phường 12, Quận 4, Tp. Hồ Chí Minh' : searchController.text;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        constraints: const BoxConstraints(minHeight: 100),
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.secondary, vertical: AppSpace.third),
        decoration: const BoxDecoration(
          color: AppColor.secondary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppRounded.secondary),
            topRight: Radius.circular(AppRounded.secondary),
          ),
          boxShadow: [BoxShadow(color: AppColor.unActive, blurRadius: 5)],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Location', style: AppText.normalBold),
          const SizedBox(height: AppSpace.primary),
          Text(location),
          const SizedBox(height: AppSpace.third),
          ElevatedButton(
            onPressed: () {
              Provider.of<LocationProvider>(context, listen: false).updateLocation(location, 0);
              Navigator.pushNamed(context, '/delivery/zone');
            },
            style: ButtonStyle(
              minimumSize: const MaterialStatePropertyAll(Size.fromHeight(45)),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRounded.minimum)),
              ),
            ),
            child: const Text('Choose location'),
          ),
        ]),
      ),
    );
  }
}
