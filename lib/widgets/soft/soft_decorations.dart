import 'package:flutter/material.dart';

import 'soft_colors.dart';
import 'soft_shadows.dart';

BoxDecoration kSoftButtonDecoration(bool isDark, double radius) =>
    BoxDecoration(
      color: kSoftButtonColor(isDark),
      borderRadius: BorderRadius.all(
        Radius.circular(radius ?? 40),
      ),
      boxShadow: <BoxShadow>[
        kSoftBottomButtonShadow(isDark),
        kSoftTopButtonShadow(isDark),
      ],
    );

BoxDecoration kSoftInvertedButtonDecoration(bool isDark, double radius) =>
    BoxDecoration(
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
