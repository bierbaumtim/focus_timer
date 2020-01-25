import 'package:flutter/material.dart';

import 'soft_colors.dart';
import 'soft_shadows.dart';

BoxDecoration kSoftDecoration({double radius, @required bool isDark}) {
  assert(isDark != null);

  return BoxDecoration(
    color: kSoftButtonColor(isDark: isDark),
    borderRadius: BorderRadius.all(
      Radius.circular(radius ?? 40),
    ),
    boxShadow: <BoxShadow>[
      kSoftBottomButtonShadow(isDark: isDark),
      kSoftTopButtonShadow(isDark: isDark),
    ],
  );
}

BoxDecoration kSoftInvertedDecoration({double radius, @required bool isDark}) {
  assert(isDark != null);

  return BoxDecoration(
    color: Colors.black.withOpacity(isDark ? 0.25 : 0.075),
    borderRadius: BorderRadius.all(
      Radius.circular(radius ?? 40),
    ),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: isDark
            ? kSoftDarkTopShadowColor.withOpacity(0.8)
            : kSoftLightTopShadowColor,
        offset: const Offset(5.0, 5.0),
        blurRadius: 3,
        spreadRadius: -3,
      ),
    ],
  );
}
