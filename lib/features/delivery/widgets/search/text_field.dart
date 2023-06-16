import 'package:flutter/material.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_typography.dart';

class DeliverySearchField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final void Function(String?) onChanged;

  const DeliverySearchField({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        autofocus: true,
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        style: AppText.label,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Let me know your location',
          hintStyle: AppText.label.copyWith(color: AppColor.unActive),
        ),
      ),
    );
  }
}
