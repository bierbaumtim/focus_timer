import 'package:flutter/material.dart';

class Page extends StatelessWidget {
  final Widget child;

  const Page({
    Key key,
    this.child,
  }) : super(key: key);

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
