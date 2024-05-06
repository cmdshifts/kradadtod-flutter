import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:kradadtod/utils/constants/sizes.dart';
import 'package:kradadtod/utils/devices/deviceUtility.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    this.icon,
    this.hasBorder = true,
    this.hasBackground = true,
  });

  final IconData? icon;
  final bool hasBorder, hasBackground;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KAppSizes.md),
      child: Container(
        width: KAppDeviceUtils.getScreenWidth(context),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Container(
              padding: const EdgeInsets.all(KAppSizes.md),
              child: const Icon(FluentIcons.compass_northwest_20_regular),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: KAppSizes.xs),
            hintText: "Search",
            hintStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
