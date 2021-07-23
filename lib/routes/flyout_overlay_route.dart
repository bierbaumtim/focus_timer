import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlyoutOverlayRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;
  final Offset bottomPosition;

  FlyoutOverlayRoute({
    required this.builder,
    required this.bottomPosition,
    RouteSettings? settings,
  }) : super(
          settings: settings,
        );

  @override
  Color get barrierColor => const Color(0x00000001);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => 'FlyoutOverlayRoute';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 350);

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: bottomPosition.dx,
            bottom: MediaQuery.of(context).size.height - bottomPosition.dy,
            child: Material(
              color: Colors.transparent,
              child: builder(context),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final size = MediaQuery.of(context).size;

    return BlurTransition(
      blurAnimation: Tween<double>(
        begin: 0,
        end: 1.5,
      ).animate(animation),
      backgroundColorAnimation: Tween<double>(
        begin: 0,
        end: 0.25,
      ).animate(animation),
      backgroundColor: const Color(0xFF000000),
      child: ScaleTransition(
        scale: CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ),
        alignment: Alignment(
          -1.0 + bottomPosition.dx / size.width,
          bottomPosition.dy / size.height + 0.0,
        ),
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInCirc,
          ),
          child: child,
        ),
      ),
    );
  }
}

class BlurTransition extends AnimatedWidget {
  final Widget child;
  final Animation<double> blurAnimation;
  final Animation<double>? backgroundColorAnimation;
  final Color? backgroundColor;

  const BlurTransition({
    required this.blurAnimation,
    required this.child,
    this.backgroundColorAnimation,
    this.backgroundColor,
  }) : super(listenable: blurAnimation);

  @override
  Widget build(BuildContext context) {
    Color? color;
    if (backgroundColorAnimation != null && backgroundColor != null) {
      color = backgroundColor!.withOpacity(backgroundColorAnimation!.value);
    }

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: blurAnimation.value,
        sigmaY: blurAnimation.value,
      ),
      child: Container(
        color: color,
        child: child,
      ),
    );
  }
}
