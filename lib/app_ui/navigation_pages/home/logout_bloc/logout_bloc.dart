
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/logout_bloc/logout_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/logout_bloc/logout_state.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';


class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<LogoutClickEvent>((event, emit) {
      logoutUserApi();
    });
  }

  void logoutUserApi() async {
    /// * api for logout user

    /***************** getting token from preference      ****************/
    String token = await getStringPref(userTokenPrefecences);
    /***************** getting user from preference  method  ****************/
    User user = await getUser();

    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };
    // request for logout
    var response = await http.delete(Uri.parse("$baseUrl$logoutApi/${user.id}"), headers: header,);
    UserResponse apiResponse = UserResponse.fromJson(jsonDecode(response.body));
    // checking for response status and emit state
      if(apiResponse.status == true){
        emit(LogoutSuccess(message: apiResponse.message!));
      }else{
        emit(LogoutError(error: apiResponse.message!));
      }
  }
}
