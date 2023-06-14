import 'package:flutter/material.dart';

import '../constants/const_color.dart';

class FunctionButton extends StatelessWidget {
  final double size;
  final Color bgColor;
  final Icon icon;
  final void Function()? onTap;

  const FunctionButton({
    super.key,
    required this.icon,
    this.size = 56,
    this.bgColor = AppColor.secondary,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: size, minHeight: size),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
        boxShadow: const [BoxShadow(color: AppColor.unActive, blurRadius: 5, offset: Offset(0, 1))],
      ),
      child: IconButton(onPressed: onTap, icon: icon),
    );
  }
}
