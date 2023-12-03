import 'package:fare_now_provider/models/NotificationClass.dart';

abstract class ServiceQuestionsRepository {
  Future<List<NotificationClass>> fetchNotifications();
}

class FakeNotificationClassRepository implements ServiceQuestionsRepository {
  @override
  Future<List<NotificationClass>> fetchNotifications() {
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
      () {
        List<NotificationClass> notifications = [];

        // Simulate some network error
        // if (true) {
        //   throw NetworkError();
        // }
        notifications.add(NotificationClass(
            details:
                'Add a little more information so you can connect with customers.',
            title: 'It looks like we need one more things.',
            status: 'Your order is confirmed',
            time: 'Yesterday',
            open: true));
        notifications.add(NotificationClass(
            details:
                'Add a little more information so you can connect with customers.',
            title: 'It looks like we need one more things.',
            status: 'Your order is confirmed',
            time: 'Yesterday',
            open: false));
        return notifications;
      },
    );
  }
}

class NetworkError extends Error {}
