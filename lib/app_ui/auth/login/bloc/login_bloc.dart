
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/auth/login/login_api.dart';
import 'package:webnsoft_solution/app_ui/auth/login/bloc/login_event.dart';
import 'package:webnsoft_solution/app_ui/auth/login/bloc/login_state.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/validation.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginClickEvent>((event, emit) {
      bool email = false, password = false;
      email =  event.email.isEmpty;
      password = event.password.isEmpty;

      if(!email && !password){
        emit(LoginLoading());

        /// * api calling for login user
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

    UserResponse response = await userLoginStatus(map);

    // emitting login states
    if(response.status == true ){
      bool isExecutiveOrDistributor = response.profileData!.user!.roleId == '4' || response.profileData!.user!.roleId == '5';
    if(isExecutiveOrDistributor){
      /// * saving user required information and login status
      setStringPref(userTokenPrefecences, response.profileData!.token!);
      saveUserPref(response.profileData!.user!,userProfileDataPrefecences);
      setBoolPref(userLoginPrefecences,true);

      emit(LoginSuccess(user : response.profileData!.user!));
    }else{
      emit(LoginError(message: 'No user found.'));
    }
    }else{
      emit(LoginError(message: response.message));
    }
  }


}
