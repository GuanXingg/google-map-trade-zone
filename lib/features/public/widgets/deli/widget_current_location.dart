import 'package:flutter/material.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';

class DeliCurrentLocation extends StatelessWidget {
  final void Function() onTap;

  const DeliCurrentLocation({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 200,
      right: AppSpace.third,
      child: Container(
        constraints: const BoxConstraints(minWidth: 56, minHeight: 56),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.secondary,
          boxShadow: [BoxShadow(color: AppColor.unActive, blurRadius: 5, offset: Offset(0, 1))],
        ),
        child: IconButton(onPressed: onTap, icon: const Icon(Icons.location_searching)),
      ),
    );
  }
}
