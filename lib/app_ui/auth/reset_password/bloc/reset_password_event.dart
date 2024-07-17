
abstract class ResetPasswordEvent {}
class ResetPasswordClickEvent extends ResetPasswordEvent{

  String oldPassword;
  String newPassword;
  String confirmNewPassword;
  ResetPasswordClickEvent(this.oldPassword,this.newPassword,this.confirmNewPassword);
}