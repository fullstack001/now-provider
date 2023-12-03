part of 'notifications_bloc.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {
  const NotificationsInitial();
  @override
  List<Object> get props => [];
}

class NotificationsLoading extends NotificationsState {
  const NotificationsLoading();
  @override
  List<Object> get props => [];
}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationClass> notifications;
  const NotificationsLoaded(this.notifications);
  @override
  List<Object> get props => [notifications];
}

class NotificationsError extends NotificationsState {
  final String message;
  const NotificationsError(this.message);
  @override
  List<Object> get props => [message];
}
