import 'package:flutter/material.dart';

import '../../routes/flyout_overlay_route.dart';
import 'settings_container.dart';

class SettingsButton extends StatelessWidget {
  final FlyoutPlacement flyoutPlacement;

  const SettingsButton({
    super.key,
    required this.flyoutPlacement,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      style: FilledButton.styleFrom(
        minimumSize: const Size.square(56),
        maximumSize: const Size.square(56),
        fixedSize: const Size.square(56),
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      onPressed: () {
        final renderBox = context.findRenderObject() as RenderBox?;

        if (renderBox != null) {
          final offset = renderBox.localToGlobal(Offset.zero);
          final RenderBox overlay = Navigator.of(context)
              .overlay!
              .context
              .findRenderObject()! as RenderBox;

          final r = RelativeRect.fromRect(
            Rect.fromLTWH(
              offset.dx,
              offset.dy,
              renderBox.size.width,
              renderBox.size.height,
            ),
            Offset.zero & overlay.size,
          );

          Navigator.of(context).push(
            FlyoutOverlayRoute(
              builder: (context) => const SettingsContainer(
                width: 400,
                height: 626,
                shrinkWrap: true,
              ),
              parentRect: r,
              placement: flyoutPlacement,
            ),
          );
        }
      },
      child: const Icon(
        Icons.settings,
        size: 24,
      ),
    );
  }
}
