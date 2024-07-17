
import 'package:webnsoft_solution/modal/login/login_response.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginClick extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {

  User user;
  LoginSuccess({required this.user});
}
class LoginError extends LoginState {
  bool? email;
  bool? password;
  String? message;
  LoginError({this.email, this.password, this.message});
}
