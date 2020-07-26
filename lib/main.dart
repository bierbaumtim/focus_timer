import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:responsive_builder/responsive_builder.dart';
// import 'package:moor_ffi/open_helper.dart';

import 'constants/theme_constants.dart';
import 'database/app_database.dart';
import 'database/daos/tasks_dao.dart';
import 'database/platforms/platform_db.dart';
import 'pages/landing_desktop.dart';
import 'pages/landing_mobile.dart';
import 'repositories/settings_repository.dart';
import 'repositories/tasks_repository.dart';
import 'state_models/current_session_model.dart';
import 'state_models/session_settings_model.dart';
import 'state_models/settings_model.dart';
import 'state_models/tasks_model.dart';
import 'utils/background_utils.dart';

// DynamicLibrary _openOnLinux() {
//   final script = File(Platform.script.toFilePath());
//   final libraryNextToScript = File('${script.path}/sqlite3.so');
//   return DynamicLibrary.open(libraryNextToScript.path);
// }

// DynamicLibrary _openOnWindows() {
//   final script = File(Platform.script.toFilePath());
//   final libraryNextToScript = File('${script.path}/sqlite3.dll');
//   return DynamicLibrary.open(libraryNextToScript.path);
// }

/// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // open.overrideFor(OperatingSystem.windows, _openOnWindows);
  // open.overrideFor(OperatingSystem.linux, _openOnLinux);

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    BackgroundUtils().setupBackgroundTask();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileLanding(),
      tablet: DesktopLanding(),
      desktop: DesktopLanding(),
    );
  }
}
