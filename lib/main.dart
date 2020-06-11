import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'constants/theme_constants.dart';
import 'database/app_database.dart';
import 'database/daos/sessions_dao.dart';
import 'database/daos/tasks_dao.dart';
import 'database/platforms/platform_db.dart';
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

  final db = AppDatabase(constructQueryExecutor(logStatements: true));

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
        ChangeNotifierProvider<SessionsModel>(
          create: (context) => SessionsModel(
            SessionsRepository(SessionsDao(db)),
            context.read<SessionSettingsModel>(),
          ),
        ),
        ChangeNotifierProvider<CurrentSessionModel>(
          create: (context) => CurrentSessionModel(
            context.read<SessionsModel>(),
            context.read<SessionSettingsModel>(),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends ViewModelWidget<SettingsModel> {
  @override
  Widget build(BuildContext context, SettingsModel model) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: model.darkmode ? darkTheme : lightTheme,
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      themeMode: model.darkmode ? ThemeMode.dark : ThemeMode.light,
      home: const MyHomePage(),
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
