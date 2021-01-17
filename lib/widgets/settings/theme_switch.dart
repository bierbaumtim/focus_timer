import 'package:flutter/widgets.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../state_models/settings_model.dart';
import '../soft/soft_switch.dart';

class ThemeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(
      builder: (context, viewmodel, _) => SoftSwitch(
        value: viewmodel.darkmode,
        activeChild: const FaIcon(FontAwesomeIcons.moon),
        deactiveChild: const FaIcon(FontAwesomeIcons.sun),
        onChanged: viewmodel.changeDarkmode,
      ),
    );
  }
}
