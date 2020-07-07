import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

import '../../constants/tween_constants.dart';
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
        padding: padding ?? EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: PlayAnimation(
          tween: MultiTween()
            ..add(
              'opacity',
              fadeInTween,
              const Duration(milliseconds: 650),
            )
            ..add(
              'translation',
              Tween<double>(
                begin: -50,
                end: 0,
              ),
              const Duration(milliseconds: 450),
              Curves.easeInOut,
            ),
          duration: const Duration(milliseconds: 1500),
          builder: (context, child, animation) => Opacity(
            opacity: animation.get('opacity') as double,
            child: Transform.translate(
              offset: Offset(0, animation.get('translation') as double),
              child: ViewModelBuilder<CurrentSessionModel>.reactive(
                viewModelBuilder: () => context.read<CurrentSessionModel>(),
                disposeViewModel: false,
                builder: (context, model, child) => Row(
                  mainAxisAlignment: model.isBreak || model.isTimerRunning
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: contentPadding ??
                          EdgeInsets.only(top: 8.0, bottom: 8),
                      child: CurrentDateTimeContainer(),
                    ),
                    if (model.isBreak || model.isTimerRunning)
                      Padding(
                        padding: contentPadding ??
                            EdgeInsets.only(top: 8.0, bottom: 8),
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
          ),
        ),
      ),
    );
  }
}
