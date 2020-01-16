import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_timer/blocs/settings/settings_bloc.dart';
import 'package:focus_timer/blocs/settings/settings_state.dart';
import 'package:focus_timer/blocs/tasks/bloc.dart';
import 'package:focus_timer/constants/hive_constants.dart';
import 'package:focus_timer/repositories/storage_repository.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'dart:math' as math;

import 'blocs/cross_platform_delegate.dart';
import 'constants/theme_constants.dart';
import 'models/session.dart';
import 'models/task.dart';
import 'pages/landing_desktop.dart';
import 'pages/landing_mobile.dart';
import 'state_models/session_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
      // BlocSupervisor.delegate = await HydratedBlocDelegate.build();
    } else {
      await Hive.initFlutter();
    }
  }

  Hive.registerAdapter<Task>(TaskAdapter());
  Hive.registerAdapter<Session>(SessionAdapter());
  await Hive.openBox(kTasksHiveBox);
  await Hive.openBox(kSessionsHiveBox);
  BlocSupervisor.delegate = await CrossPlatformDelegate.build();

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
