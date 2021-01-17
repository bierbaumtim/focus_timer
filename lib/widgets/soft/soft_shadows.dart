import 'package:flutter/material.dart';

import 'soft_colors.dart';

/// The bottom shadow to apply to [SoftButton]
BoxShadow kSoftBottomButtonShadow({required bool isDark}) => BoxShadow(
      color: isDark ? kSoftDarkBottomShadowColor : kSoftLightBottomShadowColor,
      offset: const Offset(5.0, 5.0),
      blurRadius: 10,
      spreadRadius: 1.0,
    );

/// The top shadow to apply to [SoftButton]
BoxShadow kSoftTopButtonShadow({required bool isDark}) => BoxShadow(
      color: isDark ? kSoftDarkTopShadowColor : kSoftLightTopShadowColor,
      offset: const Offset(-5.0, -5.0),
      blurRadius: 10,
      spreadRadius: 1.0,
    );

/// The inverted bottom shadow to apply to [SoftContainer]
BoxShadow kSoftInvertedBottomButtonShadow({required bool isDark}) => BoxShadow(
      color: isDark ? kSoftDarkTopShadowColor : kSoftLightTopShadowColor,
      offset: const Offset(5.0, 5.0),
      blurRadius: 3,
      spreadRadius: 1.0,
    );

/// The inverted top shadow to apply to [SoftContainer]
BoxShadow kSoftInvertedTopButtonShadow({required bool isDark}) => BoxShadow(
      color: isDark ? kSoftDarkBottomShadowColor : kSoftLightBottomShadowColor,
      offset: const Offset(-5.0, -5.0),
      blurRadius: 3,
      spreadRadius: 1.0,
    );

/// The bottom shadow to apply to [SoftContainer]
BoxShadow kSoftBottomContainerShadow({required bool isDark}) => BoxShadow(
      color: isDark ? kSoftDarkBottomShadowColor : kSoftLightBottomShadowColor,
      offset: const Offset(5.0, 5.0),
      blurRadius: 15.0,
      spreadRadius: 1.0,
    );

/// The top shadow to apply to [SoftContainer]
BoxShadow kSoftTopContainerShadow({required bool isDark}) => BoxShadow(
      color: isDark ? kSoftDarkTopShadowColor : kSoftLightTopShadowColor,
      offset: const Offset(-5.0, -5.0),
      blurRadius: 15.0,
      spreadRadius: 1.0,
    );
