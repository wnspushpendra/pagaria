import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/heading_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/auth/login/bloc/login_bloc.dart';
import 'package:webnsoft_solution/app_ui/auth/login/bloc/login_event.dart';
import 'package:webnsoft_solution/app_ui/auth/login/bloc/login_state.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_message.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? isValidEmail, isValidPassword,isLoading;
  bool showPassword = true;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, loginState) {
        /// * state for showing progressbar
        if(loginState is LoginLoading){
          setState(() => isLoading = true);
        }
        /// * state for success
        if(loginState is LoginSuccess){
          onLoginSuccess(context,loginState);
        }
        /// * state for error
        if(loginState is LoginError){
          isLoading = false;
          if(loginState.message != null ){
            snackBar(context, loginState.message.toString());
          }
          setState(() => createLoginErrorState(loginState));
        }
      },
      builder: (context, state) {
        /// * ui for login
        return Scaffold(
          backgroundColor: bodyWhite,
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(logo),
                  const Space(
                    height: 30,
                  ),
                  const HeadingText(
                    text: login,
                  ),
                  const Space(
                    height: 20,
                  ),
                  CustomTextField(
                      hint: "$email*",
                      label: "$email*",
                      controller: emailController,
                      validate: isValidEmail,
                      errorMessage: emailAddressMessage,
                      onTextChange: (value) {}),
                  CustomTextField(
                      hint: password,
                      label: password,
                      controller: passwordController,
                      isPasswordField: showPassword,
                      icon: showPassword ?const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                      onClick:() => setState(() => showPassword = !showPassword),
                      validate: isValidPassword,
                      errorMessage: passwordMessage,
                      onTextChange: (value) {}),
                  CustomButton(
                      buttonText: login,
                      buttonTextColor: bodyWhite,
                      showLoading: isLoading,
                      /// * login click action
                      onClick: () => onLoginClick())
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  onLoginClick() {
    /// * api call for login and check validate
    context.read<LoginBloc>().add(LoginClickEvent(email : emailController.text,password : passwordController.text));
  }

  /// * on login success response
  void onLoginSuccess(BuildContext context, LoginSuccess state) {
    if(state.user.roleId == '4'){
      Navigator.pushReplacementNamed(context, homeRoute,arguments: state.user);
    }else{
      Navigator.pushReplacementNamed(context, homeDistributorRoute,arguments: state.user);
    }

  }
  /// * on login validation error
  createLoginErrorState(LoginError state) {
    isValidEmail = state.email;
    isValidPassword = state.password;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }




}
