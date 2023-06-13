import 'package:flutter/material.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/constants/const_typography.dart';

class DeliSearchField extends StatelessWidget {
  const DeliSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: AppSpace.secondary,
      left: AppSpace.third,
      right: AppSpace.third,
      child: Container(
        height: AppSpace.maximum,
        decoration: BoxDecoration(
          color: AppColor.secondary,
          borderRadius: BorderRadius.circular(AppRounded.minimum),
          boxShadow: const [BoxShadow(color: AppColor.unActive, blurRadius: 5, offset: Offset(0, 2))],
        ),
        child: Row(children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpace.primary),
            child: Icon(Icons.search, size: AppIconSize.primary, color: AppColor.unActive),
          ),
          Expanded(
            child: TextField(
              readOnly: true,
              onTap: () => Navigator.pushNamed(context, '/delivery/search'),
              style: AppText.label,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Let me know your location',
                hintStyle: AppText.label.copyWith(color: AppColor.unActive),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
