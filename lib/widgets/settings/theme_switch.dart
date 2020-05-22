import 'package:flutter/widgets.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:stacked/stacked.dart';

import '../../state_models/settings_model.dart';
import '../soft/soft_switch.dart';

class ThemeSwitch extends ViewModelWidget<SettingsModel> {
  @override
  Widget build(BuildContext context, SettingsModel model) {
    return SoftSwitch(
      value: model.darkmode,
      activeChild: Icon(FontAwesome.moon_o),
      deactiveChild: Icon(FontAwesome.sun_o),
      onChanged: model.changeDarkmode,
    );
  }
}
