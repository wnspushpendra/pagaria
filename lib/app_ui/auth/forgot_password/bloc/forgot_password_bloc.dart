import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/auth/forgot_password/bloc/forgot_password_event.dart';
import 'package:webnsoft_solution/app_ui/auth/forgot_password/bloc/forgot_password_state.dart';
import 'package:webnsoft_solution/app_ui/auth/forgot_password/forgot_password_api.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';
import 'package:webnsoft_solution/utils/validation.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordClickEvent>((event, emit) {
      bool email = false;
      email = !isValidEmail(event.email);
      if(!email){
        forgotPasswordApi(event);
      }else{
        emit(ForgotPasswordError(isEmailValid: email));
      }
    });
  }

  void forgotPasswordApi(ForgotPasswordClickEvent event) async {
    String token = await getStringPref(userTokenPrefecences);
    User user = await getUser();
    Map<String, String> header = {
      'Content-Type': 'multipart/form-data',
      "Authorization": "Bearer $token",
    };
    Map<String, dynamic> map = <String, dynamic>{};
    map['user_id'] = user.id;
    map['old_password'] = event.email;


    UserResponse response = await forgotPasswordStatus(header, map);
    if (response.status == true) {
      emit(ForgotPasswordSuccess(message: response.message!));
    } else {
      emit(ForgotPasswordError(error: response.message!));
    }
  }
}
