import 'package:flutter/widgets.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../../state_models/settings_model.dart';
import '../soft/soft_switch.dart';

class ThemeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(
      builder: (context, viewmodel, _) => SoftSwitch(
        value: viewmodel.darkmode,
        activeChild: const Icon(FontAwesome.moon_o),
        deactiveChild: const Icon(FontAwesome.sun_o),
        onChanged: viewmodel.changeDarkmode,
      ),
    );
  }
}
