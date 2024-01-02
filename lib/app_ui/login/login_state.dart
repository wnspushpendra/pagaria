
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginClick extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginError extends LoginState {
  bool? email;
  bool? password;
  String? message;
  LoginError({this.email, this.password, this.message});
}
