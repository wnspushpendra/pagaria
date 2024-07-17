
import 'package:webnsoft_solution/modal/executive/target_modal.dart';

abstract class TargetState {}

class TargetInitial extends TargetState {}
class TargetLoading extends TargetState {}
class TargetSuccess extends TargetState {
  final List<Target> targetList;
  TargetSuccess({required this.targetList});
}
class TargetError extends TargetState {
  final String error;
  TargetError({required this.error});
}
