

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/my_activity/bloc/my_activity_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/my_activity/bloc/my_activity_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/my_activity/my_activity_api.dart';
import 'package:webnsoft_solution/modal/executive/my_activity_modal/my_activity_modal.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';

class MyActivityBloc extends Bloc<MyActivityEvent, MyActivityState> {
  MyActivityBloc() : super(MyActivityLoading()) {
    on<FetchMyActivityEvent>((event, emit) => myActivityEvent(event));
  }

  myActivityEvent(FetchMyActivityEvent event) async {
    // header
    Map<String, String> header =  {
      "Authorization": "Bearer ${await getStringPref(userTokenPrefecences)}",
    };
    User user = await getUserPref(userProfileDataPrefecences);
    // form body data
    Map<String, dynamic> body = <String, dynamic>{};
    body['user_id'] =  user.id.toString();
    if(event.fromShopVisit == true){
      body['status_type'] =  'shop_check_in';
    }

    try {
      MyActivityModal response = await myActivity(header, body);
      if (response.status == true && response.myActivityData != null &&
          response.myActivityData!.isNotEmpty) {
        emit(MyActivitySuccess(myActivity: response.myActivityData!));
      } else {
        emit(MyActivityError(error: response.message.toString()));
      }
    }catch(e){
      emit(MyActivityError(error: e.toString()));
    }

  }
}
