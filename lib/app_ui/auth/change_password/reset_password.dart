import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_svg_image.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/auth/change_password/bloc/change_password_bloc.dart';
import 'package:webnsoft_solution/app_ui/auth/change_password/bloc/change_password_state.dart';
import 'package:webnsoft_solution/modal/login/MarketingExecutiveLoginResponse.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});


  @override
  State<ResetPassword> createState() => _ChangePassword();
}

class _ChangePassword extends State<ResetPassword> {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();
  bool oldPasswordVisible = true;
  bool newPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(context, resetPassword,  () async{
          User? user = await getUserPref(userProfileDataPrefecences);
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushReplacementNamed(context, homeRoute,arguments: user);
          });
        }),
        body: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) {},
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding:  EdgeInsets.all(16.h),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const CustomSvgImage(image: forgotPasswordImage),
                    //  SvgPicture.asset('assets/forgot_password.svg'),
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
        ));
  }
}
