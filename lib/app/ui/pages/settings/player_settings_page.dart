import 'package:flutter/material.dart';
import 'package:i_iwara/app/ui/pages/settings/widgets/player_settings_widget.dart';
import 'package:i_iwara/app/ui/pages/settings/widgets/settings_app_bar.dart';

class PlayerSettingsPage extends StatelessWidget {
  final bool isWideScreen;

  const PlayerSettingsPage({super.key, this.isWideScreen = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingsAppBar(
        title: '播放器设置',
        isWideScreen: isWideScreen,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width > 800
                  ? 800
                  : MediaQuery.of(context).size.width,
            ),
            child: PlayerSettingsWidget(),
          ),
        ),
      ),
    );
  }
}
