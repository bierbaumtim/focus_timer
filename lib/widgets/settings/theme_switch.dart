import 'package:flutter/widgets.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../state_models/settings_model.dart';
import '../soft/soft_switch.dart';

class ThemeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsModel = Injector.get<SettingsModel>();

    return StateBuilder<SettingsModel>(
      models: [settingsModel],
      watch: (_) => settingsModel.darkmode,
      builder: (context, _) => SoftSwitch(
        value: settingsModel.darkmode,
        activeChild: Icon(FontAwesome.moon_o),
        deactiveChild: Icon(FontAwesome.sun_o),
        onChanged: settingsModel.changeDarkmode,
      ),
    );
  }
}
