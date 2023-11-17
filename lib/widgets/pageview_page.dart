import 'package:flutter/material.dart';

class Page extends StatelessWidget {
  final Widget child;

  const Page({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: SafeArea(
        child: child,
      ),
    );
  }
}
