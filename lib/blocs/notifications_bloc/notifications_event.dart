part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();
}

class GetNotifications extends NotificationsEvent {
  const GetNotifications();

  @override
  List<Object> get props => [];
}

class UpdateNotifications extends NotificationsEvent {
  final List<NotificationClass> notifications;
  const UpdateNotifications(this.notifications);

  @override
  List<Object> get props => [notifications];
}
