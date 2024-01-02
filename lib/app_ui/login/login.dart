import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/heading_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/login/login_bloc.dart';
import 'package:webnsoft_solution/app_ui/login/login_event.dart';
import 'package:webnsoft_solution/app_ui/login/login_state.dart';
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
  bool? isValidEmail, isValidPassword;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if(state is LoginSuccess){
          onPopReplace(context, homeRoute);
        }
        if(state is LoginError){
          setState(() => createLoginErrorState(state));
        }
      },
      builder: (context, state) {
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
                      hint: email,
                      label: email,
                      controller: emailController,
                      validate: isValidEmail,
                      errorMessage: emailAddressMessage,
                      onTextChange: (value) {}),
                  CustomTextField(
                      hint: password,
                      label: password,
                      controller: passwordController,
                      validate: isValidPassword,
                      errorMessage: passwordMessage,
                      onTextChange: (value) {}),
                  CustomButton(
                      buttonText: login,
                      buttonTextColor: bodyWhite,
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
    context.read<LoginBloc>().add(LoginClickEvent(email : emailController.text,password : passwordController.text));
  }

  createLoginErrorState(LoginError state) {
    isValidEmail = state.email;
    isValidPassword = state.password;
  }
}
