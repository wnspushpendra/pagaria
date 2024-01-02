
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/login/login_event.dart';
import 'package:webnsoft_solution/app_ui/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginClickEvent>((event, emit) {
      bool email = false, password = false;
      email =  event.email.isEmpty;
      password = event.password.isEmpty;

      if(!email && !password){
        emit(LoginSuccess());
        // Login Success
        checkLoginApi(event);
      }else{
        emit(LoginError(email: email,password: password));
      }
    });
  }

  void checkLoginApi(LoginClickEvent event) {}
}
