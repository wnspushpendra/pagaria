import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/error_widget.dart';
import 'package:webnsoft_solution/app_common_widges/heading_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/auth/reset_password/bloc/reset_password_bloc.dart';
import 'package:webnsoft_solution/app_ui/auth/reset_password/bloc/reset_password_event.dart';
import 'package:webnsoft_solution/app_ui/auth/reset_password/bloc/reset_password_state.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_message.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class ResetPassword extends StatefulWidget {
  final User user;
  const ResetPassword({required this.user, super.key});

  @override
  State<ResetPassword> createState() => _ChangePassword();
}

class _ChangePassword extends State<ResetPassword> {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();
  bool oldPasswordVisible = false, newPasswordVisible = false,
      isOldPasswordField = true,
      isNewPasswordField = true;
  bool? oldPass, newPass, confirmNewPass, isSamePass;
  bool? resetPasswordLoading;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async => ChangeRoutes.openHomeScreen(context, await getUser()),
      child: Scaffold(
          appBar: appBarWidget(context, resetPassword, () async {
            /// * reset password back pressed
            ChangeRoutes.openHomeScreen(context, await getUser());
          }),
          body: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
            listener: (context, changePasswordState) {
              /// * reset password loading state
              if (changePasswordState is ResetPasswordLoading) {
                setState(() => resetPasswordLoading = true);
              }

              /// * reset password error state
              if (changePasswordState is ResetPasswordSuccess) {
                resetPasswordLoading = false;
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                  ChangeRoutes.openHomeScreen(context, await getUser());
                });
                snackBar(context, changePasswordState.message);
              }

              /// * reset password error state
              if (changePasswordState is ResetPasswordError) {
                if (changePasswordState.error == 'unauthorization') {
                  backToLogin(context);
                }
                resetPasswordLoading = false;
                if (changePasswordState.error != null) {
                  snackBar(context, changePasswordState.error!);
                }
                setState(() => resetPassErrorState(changePasswordState));
              }
            },
            builder: (context, resetPasswordState) {
              /// * reset password ui
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.80,
                  padding: EdgeInsets.all(16.h),
                  alignment: Alignment.center,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const HeadingText(
                          text: 'Change Your Password 🔒',
                          align: TextAlign.center,
                          fontSize: 20,
                          color: bodyBlack,
                        ),
                        const Space(
                          height: 8,
                        ),
                        const BodyText(
                            fontSize: 14,
                            text:
                                "Your Safety Matters! Keep Your Account Secure - Update Your Password Regularly. Craft a Robust, Unique Password with Letters, Numbers, and Special Characters."),
                        const Space(
                          height: 20,
                        ),
                        CustomTextField(
                            hint: oldPassword,
                            label: oldPassword,
                            controller: oldPasswordController,
                            validate: oldPass,
                            errorMessage: oldPasswordMessage,
                            isPasswordField: isOldPasswordField,
                            icon: Icon(oldPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onClick: () =>
                                setState(() => oldPasswordVisibility()),
                            onTextChange: (value) =>
                                setState(() => oldPass = value)),
                        CustomTextField(
                            hint: newPassword,
                            label: newPassword,
                            controller: newPasswordController,
                            validate: newPass,
                            isPasswordField: isNewPasswordField,
                            icon: Icon(newPasswordVisible ? Icons.visibility : Icons.visibility_off),
                            onClick: () => setState(() => newPasswordVisibility()),
                            onTextChange: (value) => setState(() => newPass = value)),
                        if (newPass != null && newPass!)
                          CustomErrorWidget(
                              validate: !newPass!,
                              errorMessage: newPasswordMessage),
                        CustomTextField(
                            hint: confirmNewPassword,
                            label: confirmNewPassword,
                            controller: confirmNewPasswordController,
                            validate: confirmNewPass,
                            errorMessage: confirmNewPasswordMessage,
                            isPasswordField: isNewPasswordField,
                            icon: Icon(newPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onClick: () =>
                                setState(() => newPasswordVisibility()),
                            onTextChange: (value) => setState(() {
                                  isSamePass = true;
                                  if (newPasswordController.text !=
                                      confirmNewPasswordController.text) {
                                    isSamePass = false;
                                  }
                                })),
                        if (isSamePass != null && !isSamePass!)
                          CustomErrorWidget(
                              validate: isSamePass,
                              errorMessage: unMatchPasswordMessage),
                        const Space(
                          height: 20,
                        ),
                        CustomButton(
                            buttonText: 'Submit',
                            showLoading: resetPasswordLoading,

                            /// * reset password click action
                            onClick: () => resetButtonClick())
                      ]),
                ),
              );
            },
          )),
    );
  }

  /// * reset password click action
  resetButtonClick() {
    context.read<ResetPasswordBloc>().add(ResetPasswordClickEvent(
        oldPasswordController.text,
        newPasswordController.text,
        confirmNewPasswordController.text));
  }

  /// * reset password error state
  void resetPassErrorState(ResetPasswordError changePasswordState) {
    oldPass = changePasswordState.oldPassword;
    newPass = changePasswordState.newPassword;
    confirmNewPass = changePasswordState.confirmNewPassword;
    isSamePass = changePasswordState.isSamePassword;
  }

  void oldPasswordVisibility() {
    if (oldPasswordVisible) {
      oldPasswordVisible = false;
      isOldPasswordField = true;
    } else {
      oldPasswordVisible = true;
      isOldPasswordField = false;
    }
  }

  void newPasswordVisibility() {
    if (newPasswordVisible) {
      newPasswordVisible = false;
      isNewPasswordField = true;
    } else {
      newPasswordVisible = true;
      isNewPasswordField = false;
    }
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }
}
