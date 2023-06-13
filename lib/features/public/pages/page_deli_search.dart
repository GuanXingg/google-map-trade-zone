import 'package:flutter/material.dart';
import 'package:google_map_new/constants/const_color.dart';
import 'package:google_map_new/constants/const_space.dart';
import 'package:google_map_new/constants/const_typography.dart';
import 'package:google_map_new/widgets/app_bar.dart';

class DeliSearchPage extends StatefulWidget {
  const DeliSearchPage({super.key});

  @override
  State<DeliSearchPage> createState() => _DeliSearchPageState();
}

class _DeliSearchPageState extends State<DeliSearchPage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();
  bool _isFocus = false;
  bool _isDirty = false;

  void handleDeleteSearch() {
    controller.clear();
    setState(() => _isDirty = false);
  }

  @override
  void initState() {
    _focusNode.addListener(() => setState(() => _isFocus = _focusNode.hasFocus));
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
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
            color: AppColor.secondary,
            boxShadow: [BoxShadow(color: AppColor.unActive, blurRadius: 10)],
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
              Expanded(
                child: TextField(
                  autofocus: true,
                  focusNode: _focusNode,
                  controller: controller,
                  onChanged: (value) =>
                      value.isEmpty ? setState(() => _isDirty = false) : setState(() => _isDirty = true),
                  style: AppText.label,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Let me know your location',
                    hintStyle: AppText.label.copyWith(color: AppColor.unActive),
                  ),
                ),
              ),
              if (_isDirty)
                IconButton(
                  onPressed: handleDeleteSearch,
                  icon: const Icon(Icons.disabled_by_default, size: AppIconSize.primary, color: AppColor.unActive),
                ),
              if (_isFocus)
                IconButton(
                  onPressed: () => _isDirty ? Navigator.pop(context) : null,
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
