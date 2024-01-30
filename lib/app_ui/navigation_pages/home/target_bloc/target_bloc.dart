

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/target_bloc/target_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/target_bloc/target_state.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:http/http.dart' as http;

class TargetBloc extends Bloc<TargetEvent, TargetState> {
  TargetBloc() : super(TargetInitial()) {
    on<TargetFetchEvent>((event, emit) {
      /// * api for fetch user target
      targetFetchApi(event);
    });
  }

  void targetFetchApi(TargetFetchEvent event) async{
    var response = await http.post(Uri.parse(baseUrl + loginApi), body: '');
    UserResponse apiResponse = UserResponse.fromJson(jsonDecode(response.body));
  }
}
