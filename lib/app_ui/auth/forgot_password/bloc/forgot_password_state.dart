
abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}
class ForgotPasswordLoading extends ForgotPasswordState {}
class ForgotPasswordSuccess extends ForgotPasswordState {
  final String message;
  ForgotPasswordSuccess({required this.message});
}
class ForgotPasswordError extends ForgotPasswordState {
  final bool? isEmailValid;
  final String? error;
  ForgotPasswordError({ this.error,this.isEmailValid});
}
