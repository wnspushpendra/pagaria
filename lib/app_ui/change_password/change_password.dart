import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/change_password/bloc/change_password_bloc.dart';
import 'package:webnsoft_solution/app_ui/change_password/bloc/change_password_state.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';


class ChangePassword extends StatefulWidget {
  /*OtpArguments argument;
  ChangePassword(this.argument, {super.key});*/

  @override
  State<ChangePassword> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();
  bool oldPasswordVisible = true;
  bool newPasswordVisible = true;

/*  OtpArguments arguments;
  _ChangePassword(this.arguments);*/

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          appBar: appBarWidget(context, changePassword,  () async{  }),
          body: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
            listener: (context, state) {
          /*    if (state is ChangePasswordError) {
                alertStatusDialogMessage(context, state.error);
              }*/
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Container(
                  padding:  EdgeInsets.all(16.h),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 200.h,
                          child: const Image(
                            image: AssetImage(
                              "",
                            ),
                          ),
                        ),
                        const Space(height: 20,),
                        CustomTextField(hint: oldPassword, label: oldPassword, controller: oldPasswordController, onTextChange: (value)=>""),
                        CustomTextField(hint: newPassword, label: newPassword, controller: newPasswordController, onTextChange: (value)=>""),
                        CustomTextField(hint: confirmNewPassword, label: confirmNewPassword, controller: confirmNewPasswordController, onTextChange: (value)=>""),
                        const Space(height: 20,),
                        CustomButton(buttonText: 'Submit', onClick: (){})
                      ]),
                ),
              );
            },
          )),
    );
  }
}
