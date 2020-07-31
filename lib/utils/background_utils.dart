import 'package:background_fetch/background_fetch.dart';

class BackgroundUtils {
  Future<bool> setupBackgroundTask() async {
    var status = -1;

    try {
      status = await BackgroundFetch.configure(
        BackgroundFetchConfig(
          minimumFetchInterval: 15,
          enableHeadless: true,
          startOnBoot: true,
          stopOnTerminate: false,
        ),
        backgroundTask,
      );
    } on dynamic catch (_) {} finally {
      await BackgroundFetch.registerHeadlessTask(backgroundTask);
      status = await BackgroundFetch.start();
    }

    return status == BackgroundFetch.STATUS_AVAILABLE;
  }
}

void backgroundTask(String taskId) {}
