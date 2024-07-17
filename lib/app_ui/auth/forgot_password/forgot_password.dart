import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/heading_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/auth/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:webnsoft_solution/app_ui/auth/forgot_password/bloc/forgot_password_state.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  bool? isValidEmail;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async => ChangeRoutes.openHomeScreen(context, await getUser()),
      child: Scaffold(
        appBar: appBarWidget(context, 'Forgot Password',
            () async => ChangeRoutes.openHomeScreen(context, await getUser())),
        body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, forgotPasswordState) {
            if (forgotPasswordState is ForgotPasswordError) {}
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.80,
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    // Image.asset(changePasswordImage),
                    const HeadingText(
                      text: 'Forgot Your Password 🔒',
                      align: TextAlign.center,
                      fontSize: 20,
                      color: bodyBlack,
                    ),
                    const Space(
                      height: 8,
                    ),
                    const BodyText(
                      text:
                          "Oops! Forgotten your password? No worries! Click 'Forgot Password' to reset it and regain access to your account. We've got you covered!",
                      fontSize: 14,
                    ),
                    CustomTextField(
                        hint: email,
                        label: email,
                        controller: emailController,
                        onTextChange: (value) =>
                            setState(() => isValidEmail = value)),
                    CustomButton(buttonText: submit, onClick: () {})
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
