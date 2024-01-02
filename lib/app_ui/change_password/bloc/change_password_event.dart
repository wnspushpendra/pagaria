
abstract class ChangePasswordEvent {}
class ChangePasswordSubmitEvent extends ChangePasswordEvent{

  String oldPassword;
  String newPassword;
  String confirmNewPassword;
  ChangePasswordSubmitEvent(this.oldPassword,this.newPassword,this.confirmNewPassword);
}