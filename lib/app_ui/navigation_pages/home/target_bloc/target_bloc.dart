import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/target_bloc/target_api.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/target_bloc/target_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/target_bloc/target_state.dart';
import 'package:webnsoft_solution/modal/executive/target_modal.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class TargetBloc extends Bloc<TargetEvent, TargetState> {
  TargetBloc() : super(TargetInitial()) {
    on<TargetFetchEvent>((event, emit) {
      /// * api for fetch user target
      fetchTargetData(event);
    });
  }

  void fetchTargetData(TargetFetchEvent event) async {
    /***************** getting user from preference  method  ****************/
    User user = await getUser();

    Map<String, String> header = {
      "Authorization": "Bearer ${await getStringPref(userTokenPrefecences)}",
    };

    Map<String, dynamic> body = <String, dynamic>{};
    body['executive_id'] = user.id.toString();
    body['user_type'] = 'type_marketing_ex';

    emit(TargetLoading());
    try {
      TargetModal response = await targetData(header, body);
      if (response.status == true && response.target != null) {
        emit(TargetSuccess(
          targetList: response.target!,
        ));
      } else {
        emit(TargetError(error: response.message.toString()));
      }
    } catch (e) {
      emit(TargetError(error: e.toString()));
    }
  }
}
