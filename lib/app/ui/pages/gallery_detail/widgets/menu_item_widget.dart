
import 'package:flutter/material.dart';

import 'horizontial_image_list.dart';

class DefaultImageMenu extends StatelessWidget {
  final ImageItem item;
  final VoidCallback onDismiss;
  final Widget Function(BuildContext, ImageItem, Offset)? customBuilder;
  final BoxConstraints constraints;
  final Offset position;
  final List<MenuItem> menuItems;

  const DefaultImageMenu({
    super.key,
    required this.item,
    required this.onDismiss,
    this.customBuilder,
    required this.constraints,
    required this.position,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    if (customBuilder != null) {
      return customBuilder!(context, item, position);
    }

    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(4),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: menuItems.map((menuItem) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  dense: true,
                  leading: Icon(menuItem.icon),
                  title: Text(menuItem.title),
                  onTap: () {
                    onDismiss();
                    menuItem.onTap();
                  },
                ),
                const Divider(height: 1),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
