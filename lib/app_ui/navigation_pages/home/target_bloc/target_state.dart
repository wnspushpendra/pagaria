
abstract class TargetState {}

class TargetInitial extends TargetState {}
class TargetLoading extends TargetState {}
class TargetSuccess extends TargetState {
  final String message;
  TargetSuccess({required this.message});
}
class TargetError extends TargetState {
  final String error;
  TargetError({required this.error});
}
