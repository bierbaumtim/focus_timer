import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../state_models/current_session_model.dart';
import '../datetime/current_datetime_container.dart';
import '../soft/soft_container.dart';
import 'countdown_time.dart';

class TopTimeBar extends StatelessWidget {
  const TopTimeBar({
    Key key,
    this.alignment = Alignment.topCenter,
    this.padding,
    this.contentPadding,
  })  : assert(alignment != null),
        super(key: key);

  final Alignment alignment;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.topCenter,
      child: Padding(
        padding: padding ?? const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Consumer<CurrentSessionModel>(
          builder: (context, model, child) => Row(
            mainAxisAlignment: model.isBreak || model.isTimerRunning
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: contentPadding ??
                    const EdgeInsets.only(top: 8.0, bottom: 8),
                child: const CurrentDateTimeContainer(),
              ),
              if (model.isBreak || model.isTimerRunning)
                Padding(
                  padding: contentPadding ??
                      const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: SoftContainer(
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      child: CountdownTime(
                        isSmall: true,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
