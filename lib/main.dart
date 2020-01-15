import 'dart:async';
import 'dart:io';
import 'dart:js';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_timer/blocs/settings/settings_bloc.dart';
import 'package:focus_timer/blocs/settings/settings_state.dart';
import 'package:focus_timer/blocs/tasks/bloc.dart';
import 'package:focus_timer/repositories/storage_repository.dart';
import 'package:focus_timer/widgets/soft/soft_button.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'dart:math' as math;

import 'blocs/cross_platform_delegate.dart';
import 'blocs/settings/settings_event.dart';
import 'models/task.dart';
import 'state_models/session_model.dart';
import 'widgets/datetime/current_datetime_container.dart';
import 'widgets/datetime/current_time_text.dart';
import 'widgets/sessions/session_countdown.dart';
import 'widgets/soft/soft_appbar.dart';
import 'widgets/soft/soft_colors.dart';
import 'widgets/soft/soft_container.dart';
import 'widgets/tasks/add_task_tile.dart';
import 'widgets/tasks/task_tile.dart';

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
      accentColor: kSoftLightTextColor,
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
      accentColor: kSoftDarkTextColor,
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
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }

  WidgetsFlutterBinding.ensureInitialized();
  // if (!kIsWeb) {
  BlocSupervisor.delegate = await CrossPlatformDelegate.build();
  // BlocSupervisor.delegate = await HydratedBlocDelegate.build();
  // }

  runApp(
    MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(),
        ),
        BlocProvider<TasksBloc>(
          create: (context) => TasksBloc(),
        ),
      ],
      child: Injector(
        inject: [
          Inject<SessionsModel>(
            () => SessionsModel(StorageRepository()),
          ),
        ],
        builder: (context) => MyApp(),
      ),
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
                              child: SessionCountdown(),
                            ),
                          ),
                        ),
                        SizedBox(width: 96),
                        Expanded(
                          child: SoftContainer(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Stack(
                                children: <Widget>[
                                  BlocBuilder<TasksBloc, TasksState>(
                                    builder: (context, state) {
                                      if (state is TasksLoaded) {
                                        if (state.tasks.isNotEmpty) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              top: kToolbarHeight,
                                              bottom: kToolbarHeight + 8,
                                            ),
                                            child: CustomScrollView(
                                              physics: BouncingScrollPhysics(),
                                              slivers: <Widget>[
                                                SliverPadding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    bottom: 14,
                                                    top: 14,
                                                  ),
                                                  sliver: SliverList(
                                                    delegate:
                                                        SliverChildBuilderDelegate(
                                                      (context, index) =>
                                                          TaskTile(
                                                        task: state.tasks
                                                            .elementAt(index),
                                                      ),
                                                      childCount:
                                                          state.tasks.length,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Center(
                                            child: Text(
                                              'You\'ve done all your tasks',
                                            ),
                                          );
                                        }
                                      } else if (state is TasksLoading) {
                                        return Center(
                                          child: SoftContainer(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            radius: 15,
                                          ),
                                        );
                                      } else {
                                        return Center(
                                          child: Text(
                                            'Add tasks that you want to complete in future sessions',
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  Positioned(
                                    left: 12,
                                    right: 12,
                                    child: ListTile(
                                      title: Text('Tasks'),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 12,
                                    right: 12,
                                    child: AddTaskTile(),
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
