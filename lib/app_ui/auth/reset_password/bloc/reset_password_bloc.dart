import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/auth/reset_password/bloc/reset_password_event.dart';
import 'package:webnsoft_solution/app_ui/auth/reset_password/bloc/reset_password_state.dart';
import 'package:webnsoft_solution/app_ui/auth/reset_password/reset_password_api.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';
import 'package:webnsoft_solution/utils/validation.dart';


class ResetPasswordBloc
    extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitial()) {

    /// * calling reset password event
    on<ResetPasswordClickEvent>((event, emit) async {
      /// * method for  reset password validation
      validateResetPassword(event);
    });
  }

  /// ****** validating reset password     *************

  void validateResetPassword(ResetPasswordClickEvent event){
    bool oldPass = false,newPass = false,confirmNewPass = false,isPasswordSame = false;

    oldPass = event.oldPassword.isEmpty;
    newPass = event.newPassword.isEmpty || !isValidPassword(event.newPassword);
    confirmNewPass = event.confirmNewPassword.isEmpty;

    if(!oldPass && !newPass && !confirmNewPass ){
      if(newPass != confirmNewPass){
        /// * show password unMatch error
        emit(ResetPasswordError(isSamePassword: isPasswordSame));
      }else{
        /// * call reset password api
        resetPasswordApi(event);
      }
    }else{
      // validation error state
      emit(ResetPasswordError(oldPassword: oldPass,newPassword: newPass,confirmNewPassword: confirmNewPass));
    }
  }

  /// ******** calling api for reset password *********************

  void resetPasswordApi(ResetPasswordClickEvent event) async {
    /// * getting user token shared preference
    String token = await getStringPref(userTokenPrefecences);
    /// * get user by method from shared preference
    User user = await getUser();

    //header
    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };

    //body - form data
    Map<String,String> map = <String, String>{};
   map['user_id'] = user.id.toString();
    map['old_password'] = event.oldPassword;
    map['password'] = event.newPassword;
    map['confirm_password'] = event.confirmNewPassword;

    emit(ResetPasswordLoading());
    // request for api
    UserResponse response = await resetPasswordStatus(header, map,user.id!);
    // checking response status and emitting state.
    if(response.status == true){
      emit(ResetPasswordSuccess(message: response.message!));
    }else{
      emit(ResetPasswordError(error: response.message));

    }
  }
}
