import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';

import '../change_password_api.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordValide()) {
    on<ChangePasswordSubmitEvent>((event, emit) async {

        emit(ChangePasswordLoading());
       /* String userId = await getStringPref(Constant.userId);
        String token = await getStringPref(Constant.newToken);*/
        var header = {
          "Authorization": "Bearer ",
          "userId": '',
        };

        Map<String, String> body = {
          "old_password": event.oldPassword,
          "new_password": event.newPassword,
          "confirm_password": event.confirmNewPassword
        };

     /*   MessageResponse response = await getChangePasswordStatus(header, body);
        if (response.statusCode == 200) {
          emit(ChangePasswordData(response));
        } else {
          emit(ChangePasswordError(response.message.toString()));
        }*/
    });
  }
}
