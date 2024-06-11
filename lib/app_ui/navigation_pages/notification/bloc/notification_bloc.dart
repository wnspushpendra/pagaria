


import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/api_service/api_urls.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/notification/bloc/notification_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/notification/bloc/notification_state.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/notification/notification_count.dart';
import 'package:webnsoft_solution/modal/notification/notification_modal.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:http/http.dart' as http;

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<NotificationFetchEvent>((event, emit) => notificationEvent(event));
    on<NotificationCountEvent>((event, emit) => notificationCount(event));
    on<NotificationReadUnreadUpdateEvent>((event, emit) => notificationReadUnread(event));
  }
  notificationEvent(NotificationFetchEvent event) async {
    Map<String,String> map = <String,String>{};
    map['user_id'] = await ChangeRoutes.getUserId();
    map['type'] = 'user';
    try {
      var response = await http.post(
        Uri.parse(baseUrl + notificationApi),
        headers: await ChangeRoutes.getHeaders(),
        body: map,
      );
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<dynamic>? dataList = responseData['record'];
        List<NotificationData>? data = dataList?.map((item) => NotificationData.fromJson(item)).toList();
        if(data != null && data.isNotEmpty){
          emit(NotificationSuccess(notification: data));
        }else{
          emit(NotificationError(error: responseData['message']));}
      } else {
        emit(NotificationError(error: responseData['message']));
      }
    } catch (e) {
      emit(NotificationError(error: e.toString()));
    }



  }
  notificationCount(NotificationCountEvent event) async {

    Map<String,String> map = <String,String>{};
    map['user_id'] = await ChangeRoutes.getUserId();
    map['user_type'] = 'user';
    try {
      var response = await http.post(
        Uri.parse(baseUrl + notificationCountApi),
        headers: await ChangeRoutes.getHeaders(),
        body: map,
      );
      print(baseUrl+notificationCountApi);
      Map<String, dynamic> responseBody = json.decode(response.body);
      NotificationCountModal notificationCount = NotificationCountModal.fromJson(responseBody);
      if (response.statusCode == 200) {
        emit(NotificationSuccess(count: notificationCount.count.toString()));
      }
    } catch (e) {
      emit(NotificationError(error: e.toString()));
    }
  }

  notificationReadUnread(NotificationReadUnreadUpdateEvent event) async {
    Map<String,String> map = <String,String>{};
    map['user_id'] = await ChangeRoutes.getUserId();
    map['user_type'] = 'user';
    try {
      var response = await http.post(
        Uri.parse(baseUrl + notificationReadUnreadApi),
        headers: await ChangeRoutes.getHeaders(),
        body: map,
      );
      if (response.statusCode == 200) {
      //  emit(NotificationSuccess(count: notificationCount.count.toString()));
      }
    } catch (e) {
      emit(NotificationError(error: e.toString()));
    }



  }

}
