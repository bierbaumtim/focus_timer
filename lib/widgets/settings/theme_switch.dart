import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

import '../../state_models/settings_model.dart';

class ThemeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(
      builder: (context, viewmodel, _) =>
          CupertinoSlidingSegmentedControl<bool>(
        children: {
          false: const Text('Light'),
          true: const Text('Dark'),
        },
        groupValue: viewmodel.darkmode,
        onValueChanged: (value) => viewmodel.changeDarkmode(value!),
      ),
    );
  }
}
