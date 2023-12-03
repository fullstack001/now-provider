import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fare_now_provider/models/NotificationClass.dart';
import 'package:fare_now_provider/blocs/notifications_bloc/notifications_repository.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final ServiceQuestionsRepository repository =
      FakeNotificationClassRepository();

  NotificationsBloc({userRepository}) : super(NotificationsInitial()) {
    //  userRepository = NotificationRepository();
  }

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    // Emitting a state from the asynchronous generator
    yield NotificationsLoading();
    // Branching the executed logic by checking the event type
    if (event is GetNotifications) {
      // Emit either Loaded or Error
      try {
        final notifications = await repository.fetchNotifications();
        yield NotificationsLoaded(notifications);
      } on NetworkError {
        yield NotificationsError(
            "Couldn't fetch notifications. Is the device online?");
      }
    } else if (event is UpdateNotifications) {
      // Emit either Loaded or Error
      try {
        yield NotificationsLoaded(event.notifications);
      } on NetworkError {
        yield NotificationsError(
            "Couldn't fetch notifications. Is the device online?");
      }
    }
  }
}
