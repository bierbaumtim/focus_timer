import 'dart:io';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'constants/hive_constants.dart';
import 'constants/theme_constants.dart';
import 'models/session.dart';
import 'models/task.dart';
import 'pages/landing_desktop.dart';
import 'pages/landing_mobile.dart';
import 'repositories/sessions_repository.dart';
import 'repositories/settings_repository.dart';
import 'repositories/tasks_repository.dart';
import 'state_models/current_session_model.dart';
import 'state_models/session_model.dart';
import 'state_models/session_settings_model.dart';
import 'state_models/settings_model.dart';
import 'state_models/tasks_model.dart';

/// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool useDesktop;

  if (!kIsWeb) {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
    } else {
      await Hive.initFlutter();
    }
  }

  if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
    Hive.registerAdapter<Task>(TaskAdapter());
    Hive.registerAdapter<Session>(SessionAdapter());
    await Hive.openBox(kTasksHiveBox);
    await Hive.openBox(kSessionsHiveBox);
    await Hive.openBox(kSettingsHiveBox);
    useDesktop = false;
  } else {
    useDesktop = true;
  }

  runApp(Injector(
    inject: [
      Inject<SettingsModel>(
        () => SettingsModel(
          useDesktop ? DesktopSettingsRepository() : SettingsRepository(),
        ),
      ),
      Inject<SessionSettingsModel>(
        () => SessionSettingsModel(
          useDesktop ? DesktopSettingsRepository() : SettingsRepository(),
        ),
      ),
      Inject<SessionsModel>(
        () => SessionsModel(
          useDesktop ? DesktopSessionsRepository() : SessionsRepository(),
          Injector.get<SessionSettingsModel>(),
        ),
      ),
      Inject<TasksModel>(
        () => TasksModel(
          useDesktop ? DesktopTasksRepository() : TasksRepository(),
        ),
      ),
      Inject<CurrentSessionModel>(
        () => CurrentSessionModel(
          Injector.get<SessionsModel>(),
          Injector.get<SessionSettingsModel>(),
        ),
      ),
    ],
    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsModel = Injector.get<SettingsModel>();

    return StateBuilder<SettingsModel>(
      models: [settingsModel],
      builder: (context, _) {
        final darkmode = settingsModel.darkmode;

        return MaterialApp(
          title: 'Flutter Demo',
          theme: darkmode ? darkTheme : lightTheme,
          debugShowCheckedModeBanner: false,
          darkTheme: darkTheme,
          themeMode: darkmode ? ThemeMode.dark : ThemeMode.light,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileLanding(),
      tablet: DesktopLanding(),
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
    final path = Path();

    // Method to convert degree to radians
    num degToRad(num deg) => deg * (math.pi / 180.0);

    path.moveTo(size.width * 0.15, 0);
    path.lineTo(0, size.height * 0.05);
    path.lineTo(0, size.height * 0.95);
    // path.lineTo(size.width * 0.15, size.height);
    path.addArc(
      Rect.fromLTWH(
          0, size.height * 0.85, size.width * 0.5, size.height * 0.15),
      degToRad(-180) as double,
      degToRad(-90) as double,
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
