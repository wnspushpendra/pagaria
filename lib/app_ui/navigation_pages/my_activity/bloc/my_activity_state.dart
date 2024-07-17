
import 'package:webnsoft_solution/modal/executive/my_activity_modal/my_activity_modal.dart';

abstract class MyActivityState {}

class MyActivityLoading extends MyActivityState {}
class MyActivitySuccess extends MyActivityState {
  final List<MyActivityData> myActivity;
  MyActivitySuccess({required this.myActivity});

}
class MyActivityError extends MyActivityState {
  final String error;
  MyActivityError({required this.error});
}
