
import 'package:flutter/cupertino.dart';

abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {
  final String message;
  ResetPasswordSuccess({required this.message});
}

class ResetPasswordError extends ResetPasswordState {
  bool? oldPassword;
  bool? newPassword;
  bool? confirmNewPassword;
  bool? isSamePassword;
  String? error;

  ResetPasswordError({this.oldPassword,this.newPassword,this.confirmNewPassword,this.isSamePassword,this.error});
}
