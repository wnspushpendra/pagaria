
import 'package:webnsoft_solution/modal/notification/notification_modal.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}
class NotificationSuccess extends NotificationState {
  final List<NotificationData> notification;
  NotificationSuccess({required this.notification});
}
class NotificationError extends NotificationState {
  final String error;
  NotificationError({required this.error});
}
