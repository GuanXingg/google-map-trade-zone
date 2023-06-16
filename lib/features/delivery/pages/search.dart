import 'package:flutter/material.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/widgets/app_bar.dart';

import '../widgets/search/text_field.dart';

class DeliverySearchPage extends StatefulWidget {
  final TextEditingController controller;
  final void Function() handleSubmit;

  const DeliverySearchPage({super.key, required this.controller, required this.handleSubmit});

  @override
  State<DeliverySearchPage> createState() => _DeliverySearchPageState();
}

class _DeliverySearchPageState extends State<DeliverySearchPage> {
  final FocusNode focusNode = FocusNode();

  bool _isFocus = false;
  bool _isDirty = false;

  void handleDeleteSearch() {
    widget.controller.clear();
    setState(() => _isDirty = false);
  }

  void handleOnChangeValue(String? value) =>
      (value == null || value.isEmpty) ? setState(() => _isDirty = false) : setState(() => _isDirty = true);

  @override
  void initState() {
    focusNode.addListener(() => setState(() => _isFocus = focusNode.hasFocus));
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpace.secondary, horizontal: AppSpace.third),
          decoration: const BoxDecoration(
            boxShadow: [BoxShadow(color: AppColor.unActive, blurRadius: 10)],
            color: AppColor.secondary,
          ),
          child: Container(
            height: AppSpace.maximum,
            decoration: BoxDecoration(
              color: AppColor.secondary,
              borderRadius: BorderRadius.circular(AppRounded.minimum),
              border: Border.all(width: 1, color: AppColor.unActive),
            ),
            child: Row(children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpace.primary),
                child: Icon(Icons.search, size: AppIconSize.primary, color: AppColor.unActive),
              ),
              DeliverySearchField(focusNode: focusNode, controller: widget.controller, onChanged: handleOnChangeValue),
              if (_isDirty)
                IconButton(
                  onPressed: handleDeleteSearch,
                  icon: const Icon(Icons.disabled_by_default, size: AppIconSize.primary, color: AppColor.unActive),
                ),
              if (_isFocus)
                IconButton(
                  onPressed: _isDirty ? widget.handleSubmit : null,
                  icon: Icon(
                    Icons.send,
                    size: AppIconSize.primary,
                    color: _isDirty ? AppColor.active : AppColor.unActive,
                  ),
                ),
            ]),
          ),
        )
      ]),
    );
  }
}
