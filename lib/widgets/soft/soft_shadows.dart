import 'package:flutter/material.dart';
import 'package:focus_timer/widgets/soft/soft_colors.dart';

BoxShadow kSoftBottomButtonShadow(bool isDark) => BoxShadow(
      color: isDark ? kSoftDarkBottomShadowColor : kSoftLightBottomShadowColor,
      offset: const Offset(5.0, 5.0),
      blurRadius: 10,
      spreadRadius: 1.0,
    );

BoxShadow kSoftTopButtonShadow(bool isDark) => BoxShadow(
      color: isDark ? kSoftDarkTopShadowColor : kSoftLightTopShadowColor,
      offset: const Offset(-5.0, -5.0),
      blurRadius: 10,
      spreadRadius: 1.0,
    );

BoxShadow kSoftInvertedBottomButtonShadow(bool isDark) => BoxShadow(
      color: isDark ? kSoftDarkTopShadowColor : kSoftLightTopShadowColor,
      offset: const Offset(5.0, 5.0),
      blurRadius: 3,
      spreadRadius: 1.0,
    );

BoxShadow kSoftInvertedTopButtonShadow(bool isDark) => BoxShadow(
      color: isDark ? kSoftDarkBottomShadowColor : kSoftLightBottomShadowColor,
      offset: const Offset(-5.0, -5.0),
      blurRadius: 3,
      spreadRadius: 1.0,
    );

BoxShadow kSoftBottomContainerShadow(bool isDark) => BoxShadow(
      color: isDark ? kSoftDarkBottomShadowColor : kSoftLightBottomShadowColor,
      offset:const Offset(5.0, 5.0),
      blurRadius: 15.0,
      spreadRadius: 1.0,
    );

BoxShadow kSoftTopContainerShadow(bool isDark) => BoxShadow(
      color: isDark ? kSoftDarkTopShadowColor : kSoftLightTopShadowColor,
      offset:const Offset(-5.0, -5.0),
      blurRadius: 15.0,
      spreadRadius: 1.0,
    );
