import 'dart:ui';

import 'package:flutter/material.dart';

enum FlyoutPlacement { topLeft, bottomLeft, topRight, bottomRight }

class FlyoutOverlayRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;
  final RelativeRect parentRect;
  final FlyoutPlacement placement;

  FlyoutOverlayRoute({
    required this.builder,
    required this.parentRect,
    this.placement = FlyoutPlacement.bottomLeft,
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
          if (placement == FlyoutPlacement.bottomLeft)
            Positioned(
              left: parentRect.left,
              bottom: parentRect.bottom,
              child: Material(
                color: Colors.transparent,
                child: builder(context),
              ),
            )
          else if (placement == FlyoutPlacement.topLeft)
            Positioned(
              left: parentRect.left,
              top: parentRect.top,
              child: Material(
                color: Colors.transparent,
                child: builder(context),
              ),
            )
          else if (placement == FlyoutPlacement.bottomRight)
            Positioned(
              right: parentRect.right,
              bottom: parentRect.bottom,
              child: Material(
                color: Colors.transparent,
                child: builder(context),
              ),
            )
          else
            Positioned(
              right: parentRect.right,
              top: parentRect.top,
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

    final alignment = switch (placement) {
      FlyoutPlacement.topLeft => Alignment(
          -1.0 + parentRect.left / size.width,
          -1.0 + (parentRect.top / size.height * 2),
        ),
      FlyoutPlacement.bottomLeft =>
        Alignment(-1.0 + parentRect.left / size.width, 1),
      FlyoutPlacement.topRight => Alignment(
          1.0 - parentRect.right / size.width,
          -1.0 + (parentRect.top / size.height * 2),
        ),
      FlyoutPlacement.bottomRight =>
        Alignment(1.0 - parentRect.right / size.width, 1),
    };

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
        alignment: alignment,
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
    Key? key,
    required this.blurAnimation,
    required this.child,
    this.backgroundColorAnimation,
    this.backgroundColor,
  }) : super(key: key, listenable: blurAnimation);

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
