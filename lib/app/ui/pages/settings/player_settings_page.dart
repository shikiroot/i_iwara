import 'package:flutter/material.dart';
import 'package:i_iwara/app/ui/pages/settings/widgets/player_settings_widget.dart';

class PlayerSettingsPage extends StatelessWidget {
  const PlayerSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('播放器设置'),
        elevation: 2,
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
