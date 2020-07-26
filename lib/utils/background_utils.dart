import 'package:background_fetch/background_fetch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackgroundUtils {
  Future<void> setupBackgroundTask() async {
    var status = -1;
    final prefs = await SharedPreferences.getInstance();

    try {
      status = await BackgroundFetch.configure(
        BackgroundFetchConfig(
          minimumFetchInterval: 15,
          enableHeadless: true,
          startOnBoot: true,
          stopOnTerminate: false,
        ),
        calculateSomething,
      );
      prefs.setString('background_task_config', 'config ended with $status');
    } on dynamic catch (e) {
      prefs.setString(
        'background_task_config',
        'config ended with $status,\n ${e.toString()}',
      );
    } finally {
      await BackgroundFetch.registerHeadlessTask(calculateSomething);
      status = await BackgroundFetch.start();
      prefs.setString('background_task_startup', 'startup ended with $status');
    }
  }
}

void calculateSomething(String taskId) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
      'background_task_calc',
      'works_fine',
    );
  } on dynamic catch (e) {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
      'background_task_calc',
      e.toString(),
    );
  } finally {
    BackgroundFetch.finish(taskId);
  }
}
