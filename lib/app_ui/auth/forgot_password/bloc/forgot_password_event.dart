
abstract class ForgotPasswordEvent {}
 class ForgotPasswordClickEvent extends ForgotPasswordEvent {
  final String email;
  ForgotPasswordClickEvent({required this.email});
 }
