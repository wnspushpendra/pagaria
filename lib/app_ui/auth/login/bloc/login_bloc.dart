
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/auth/login/login_api.dart';
import 'package:webnsoft_solution/app_ui/auth/login/bloc/login_event.dart';
import 'package:webnsoft_solution/app_ui/auth/login/bloc/login_state.dart';
import 'package:webnsoft_solution/modal/login/MarketingExecutiveLoginResponse.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginClickEvent>((event, emit) {
      bool email = false, password = false;
      email =  event.email.isEmpty;
      password = event.password.isEmpty;

      if(!email && !password){
        emit(LoginLoading());
        checkLoginApi(event);
      }else{
        emit(LoginError(email: email,password: password));
      }
    });
  }

  void checkLoginApi(LoginClickEvent event) async{
    Map<String,dynamic> map = <String, dynamic>{};
    map['email'] = event.email;
    map['password'] = event.password;

    MarketingExecutiveLoginResponse response = await userLoginStatus(map);
    if(response.status == true ){
      setStringPref(userTokenPrefecences, response.record!.token!);
      saveUserPref(response.record!.user!,userProfileDataPrefecences);
      setBoolPref(userLoginPrefecences,true);
      emit(LoginSuccess(user : response.record!.user!));
    }else{
      emit(LoginError(message: response.message));
    }
  }
}
