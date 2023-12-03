import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AllNotificationController extends GetxController {
  ServiceReposiotry _reposiotry = ServiceReposiotry();
  var loading = false.obs;
  var allNotification = [].obs;

  getAllNotifications() {
    loadingView(allNotification.isEmpty);
    _reposiotry.getAllNotifications().then((value) {
      print("sdf");
      if (!value.error) {
        allNotification(value.allNotificationsData);
        allNotification.refresh();
      }

      loadingView(false);
    }, onError: (exception,stackTrace) async {

      await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
      );
      loadingView(false);
      print("$exception");
    });
  }

  void loadingView(bool flag) {
    loading(flag);
    loading.refresh();
  }
}
