import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../state_models/settings_model.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<SettingsModel>(
      builder: (context, viewmodel, _) =>
          CupertinoSlidingSegmentedControl<bool>(
        children: const {
          false: Text('Light'),
          true: Text('Dark'),
        },
        groupValue: viewmodel.darkmode,
        backgroundColor: ElevationOverlay.applySurfaceTint(
          theme.colorScheme.surface,
          theme.colorScheme.surfaceTint,
          4,
        ),
        thumbColor: theme.colorScheme.secondaryContainer,
        onValueChanged: (value) => viewmodel.changeDarkmode(value!),
      ),
    );
  }
}
