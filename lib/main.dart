import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'constants/theme_constants.dart';
import 'database/app_database_interface.dart';
import 'database/tasks_dao.dart';
import 'pages/landing_desktop.dart';
import 'pages/landing_mobile.dart';
import 'repositories/settings_repository.dart';
import 'repositories/tasks_repository.dart';
import 'state_models/current_session_model.dart';
import 'state_models/session_settings_model.dart';
import 'state_models/settings_model.dart';
import 'state_models/tasks_model.dart';

/// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = await IAppDatabase().database;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsModel>(
          create: (context) => SettingsModel(
            SettingsRepository(),
          ),
        ),
        ChangeNotifierProvider<SessionSettingsModel>(
          create: (context) => SessionSettingsModel(
            SettingsRepository(),
          ),
        ),
        ChangeNotifierProvider<TasksModel>(
          create: (context) => TasksModel(
            TasksRepository(TasksDao(db)),
          ),
        ),
        ChangeNotifierProvider<CurrentSessionModel>(
          create: (context) => CurrentSessionModel(
            context.read<SessionSettingsModel>(),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(
      builder: (context, model, _) => MaterialApp(
        title: 'Focus Timer',
        theme: model.darkmode ? darkTheme : lightTheme,
        debugShowCheckedModeBanner: false,
        darkTheme: darkTheme,
        themeMode: model.darkmode ? ThemeMode.dark : ThemeMode.light,
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileLanding(),
      tablet: DesktopLanding(),
      desktop: DesktopLanding(),
    );
  }
}
