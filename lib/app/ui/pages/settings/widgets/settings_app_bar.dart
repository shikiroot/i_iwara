import 'package:flutter/material.dart';

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isWideScreen;

  const SettingsAppBar({
    super.key,
    required this.title,
    this.isWideScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      elevation: 2,
      automaticallyImplyLeading: !isWideScreen, // 在宽屏模式下不显示返回按钮
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
} 