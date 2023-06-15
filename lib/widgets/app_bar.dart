import 'package:flutter/material.dart';

AppBar customAppBar({Widget? leading, List<Widget>? actions}) => AppBar(
      title: Image.asset('assets/images/logo-symbol.png', width: 120),
      centerTitle: true,
      leading: leading,
      actions: actions,
    );
