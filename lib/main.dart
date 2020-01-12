import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_timer/blocs/settings/settings_bloc.dart';
import 'package:focus_timer/blocs/settings/settings_state.dart';
import 'package:focus_timer/widgets/soft/soft_button.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:simple_animations/simple_animations.dart';

import 'dart:math' as math;

import 'blocs/cross_platform_delegate.dart';
import 'blocs/settings/settings_event.dart';
import 'widgets/datetime/current_datetime_container.dart';
import 'widgets/datetime/current_time_text.dart';
import 'widgets/soft/soft_colors.dart';
import 'widgets/soft/soft_container.dart';

List<Shadow> lightTextShadow = <Shadow>[
  Shadow(
    color: Colors.grey[500],
    offset: Offset(5.0, 5.0),
    blurRadius: 15.0,
  ),
  Shadow(
    color: Colors.white,
    offset: Offset(-5.0, -5.0),
    blurRadius: 15.0,
  ),
];

List<Shadow> darkTextShadow = <Shadow>[
  Shadow(
    color: Colors.grey[900],
    offset: Offset(5.0, 5.0),
    blurRadius: 15.0,
  ),
  Shadow(
    color: Colors.grey[800],
    offset: Offset(-5.0, -5.0),
    blurRadius: 15.0,
  ),
];

ThemeData get lightTheme => ThemeData(
      brightness: Brightness.light,
      canvasColor: kSoftLightBackgroundColor,
      iconTheme: IconThemeData(
        color: kSoftLightTextColor,
      ),
      textTheme: TextTheme(
        title: TextStyle(
          shadows: lightTextShadow,
          color: kSoftLightTextColor,
        ),
      ),
    );

ThemeData get darkTheme => ThemeData(
      brightness: Brightness.dark,
      iconTheme: IconThemeData(
        color: kSoftDarkTextColor,
      ),
      textTheme: TextTheme(
        title: TextStyle(
          shadows: darkTextShadow,
          color: kSoftDarkTextColor,
        ),
      ),
    );

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (!kIsWeb) {
  BlocSupervisor.delegate = await CrossPlatformDelegate.build();
  // BlocSupervisor.delegate = await HydratedBlocDelegate.build();
  // }

  runApp(
    BlocProvider<SettingsBloc>(
      create: (context) => SettingsBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final darkmode = state is SettingsLoaded ? state.darkmode : true;

        return MaterialApp(
          title: 'Flutter Demo',
          theme: darkmode ? darkTheme : lightTheme,
          debugShowCheckedModeBanner: false,
          darkTheme: darkTheme,
          themeMode: darkmode ? ThemeMode.dark : ThemeMode.light,
          home: MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileLanding(),
      desktop: DesktopLanding(),
    );
  }
}

class DesktopLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: PageView.custom(
          scrollDirection: Axis.vertical,
          pageSnapping: true,
          childrenDelegate: SliverChildListDelegate(
            <Widget>[
              Stack(
                children: <Widget>[
                  SoftAppBar(
                    height: kToolbarHeight + 14,
                    titleStyle: theme.textTheme.title.copyWith(fontSize: 35),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: CurrentDateTimeContainer(),
                    ),
                  ),
                  Positioned(
                    left: kToolbarHeight,
                    right: kToolbarHeight,
                    bottom: kToolbarHeight,
                    top: kToolbarHeight + 20,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: SoftContainer(
                            height: 400,
                            radius: 40,
                            child: Center(
                              child: CurrentTimeText(),
                            ),
                          ),
                        ),
                        SizedBox(width: 96),
                        Expanded(
                          child: SoftContainer(
                            // width: double.infinity,
                            // height: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text('Tasks'),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) =>
                                          TaskTile(),
                                      itemCount: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                color: darkTheme.canvasColor,
              ),
              Container(
                color: lightTheme.canvasColor,
              ),
              Container(
                color: darkTheme.canvasColor,
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverFillViewport(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          color: theme.canvasColor,
                          height: kToolbarHeight + 14,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 24,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Focus Timer',
                                  style: theme.textTheme.title.copyWith(
                                    fontSize: 35,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.wb_sunny),
                                  onPressed: () =>
                                      BlocProvider.of<SettingsBloc>(context)
                                        ..add(ChangeTheme()),
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: CurrentDateTimeContainer(),
                        ),
                      ),
                      Positioned(
                        left: kToolbarHeight,
                        right: kToolbarHeight,
                        bottom: kToolbarHeight,
                        top: kToolbarHeight + 20,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: SoftContainer(
                                height: 400,
                                radius: 40,
                                child: Center(
                                  child: CurrentTimeText(),
                                ),
                              ),
                            ),
                            SizedBox(width: 96),
                            Expanded(
                              child: SoftContainer(
                                width: double.infinity,
                                height: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text('Tasks'),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemBuilder: (context, index) =>
                                              CheckboxListTile(
                                            value: index & 1 == 0,
                                            onChanged: (_) => null,
                                            title: Text('Task: $index'),
                                          ),
                                          itemCount: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: darkTheme.canvasColor,
                  ),
                  Container(
                    color: lightTheme.canvasColor,
                  ),
                  Container(
                    color: darkTheme.canvasColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskTile extends StatefulWidget {
  const TaskTile({Key key}) : super(key: key);

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = false;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CheckboxListTile(
      value: isChecked,
      onChanged: (value) => setState(() => isChecked = value),
      title: Text('Task: $isChecked'),
      activeColor: isDark ? Colors.grey[500] : Colors.grey[900],
    );
  }
}

class MobileLanding extends StatefulWidget {
  @override
  _MobileLandingState createState() => _MobileLandingState();
}

class _MobileLandingState extends State<MobileLanding> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.bottom,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.custom(
        scrollDirection: Axis.vertical,
        pageSnapping: true,
        childrenDelegate: SliverChildListDelegate(
          <Widget>[
            Column(
              children: <Widget>[
                SoftAppBar(
                  height: kToolbarHeight + 14,
                ),
                Expanded(
                  flex: 7,
                  child: ControlledAnimation(
                    duration: Duration(milliseconds: 1000),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, animation) {
                      return Opacity(
                        opacity: animation,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SoftContainer(
                              width: 300,
                              height: 300,
                              radius: 200,
                              child: Center(
                                child: AutoSizeText(
                                  '12:00',
                                  maxLines: 1,
                                  minFontSize: 60,
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? kSoftLightTopShadowColor
                                            : kSoftDarkTopShadowColor,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      height: kToolbarHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SoftButton(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(
                                Icons.play_arrow,
                                size: 36,
                              ),
                            ),
                            radius: 15,
                          ),
                          SizedBox(width: 36),
                          SoftButton(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(
                                Icons.pause,
                                size: 36,
                              ),
                            ),
                            radius: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: darkTheme.canvasColor,
              child: Theme(
                data: darkTheme,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                        child: CurrentDateTimeContainer(
                          useDarkTheme: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => TaskTile(),
                        itemCount: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: lightTheme.canvasColor,
            ),
            Container(
              color: darkTheme.canvasColor,
            ),
          ],
        ),
      ),
    );
  }
}

class SoftAppBar extends StatelessWidget {
  const SoftAppBar({
    Key key,
    this.titleStyle,
    this.height = kToolbarHeight,
  }) : super(key: key);

  final TextStyle titleStyle;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        color: theme.canvasColor,
        height: height,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Focus Timer',
                style: theme.textTheme.title,
              ),
              IconButton(
                icon: Icon(Icons.wb_sunny),
                onPressed: () =>
                    BlocProvider.of<SettingsBloc>(context)..add(ChangeTheme()),
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClockElementPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 20;
    var path = Path();

    // Method to convert degree to radians
    num degToRad(num deg) => deg * (math.pi / 180.0);

    path.moveTo(size.width * 0.15, 0);
    path.lineTo(0, size.height * 0.05);
    path.lineTo(0, size.height * 0.95);
    // path.lineTo(size.width * 0.15, size.height);
    path.addArc(
      Rect.fromLTWH(
          0, size.height * 0.85, size.width * 0.5, size.height * 0.15),
      degToRad(-180),
      degToRad(-90),
    );
    path.lineTo(size.width, size.height * 0.925);
    path.lineTo(size.width, size.height * 0.075);
    path.close();

    canvas.drawPath(path, paint);

    // canvas.drawRect(Rect.fromLTWH(0, 0, 20, 100), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
