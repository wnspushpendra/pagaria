import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/gender_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile_image_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile_state.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_message.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aadharNumberController = TextEditingController();
  TextEditingController panCardController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  bool? isFirstName,
      isLastName,
      isMobileNumber,
      isEmail,
      isAadharNumber,isValidPanCard,
      isGender,
      isStreet,
      isCity,
      isState,
      isPinCode;
  bool editProfile = false;
  String genderValue = '';
  late File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, 'Profile', () {
        if(editProfile){
          setState(() => editProfile = false);
        }else{
          onPopReplace(context, homeRoute);
        }
      }),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, profileState) {
          if (profileState is ProfileError) {
            setState(() => updateProfileErrorState(profileState));
          }
        },
        builder: (context, profileState) {
          var width = MediaQuery.of(context).size.width;
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                   ProfileImageWidget(onFileChange: (File value) => setState(() => file = value), networkUrl: networkImage,),
                 mobileView(),
                 /* if (width > 600) desktopView(),
                  if (width < 400) mobileView(),*/

                  SelectGender(gender: genderValue, onChange: (String value) => setState(() => genderValue = value),),
                  CustomButton(
                      buttonText: 'Update', onClick: () => profileButtonClick())
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  profileButtonClick() {
    setState(() => editProfile = true);
    context.read<ProfileBloc>().add(ProfileUpdateClickEvent(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        mobileNumber: mobileNumberController.text,
        email: emailController.text,
        aadharNumber: aadharNumberController.text,
        panNumber :panCardController.text,
        street: streetController.text,
        city: cityController.text,
        state: stateController.text,
        pinCode: pinCodeController.text,
        gender: genderValue));
  }
  updateProfileErrorState(ProfileError profileState) {
    isFirstName = profileState.firstName;
    isLastName = profileState.lastName;
    isMobileNumber = profileState.mobileNumber;
    isEmail = profileState.email;
    isAadharNumber = profileState.aadharNumber;
    isValidPanCard = profileState.panNumber;
    isStreet = profileState.street;
    isCity = profileState.city;
    isState = profileState.state;
    isPinCode = profileState.pinCode;
    isGender = profileState.gender;
  }

  Widget desktopView(){
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: fistName,
                  label: fistName,
                  controller: firstNameController,
                  editable: editProfile,
                  validate: isFirstName,
                  errorMessage: fistNameMessage,
                  onTextChange: (value) => setState(() => isFirstName = value)),
            ),
            Space(width: 10.h,),
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: lastName,
                  label: lastName,
                  controller: lastNameController,
                  editable: editProfile,
                  validate: isLastName,
                  errorMessage: lastNameMessage,
                  onTextChange: (value) =>
                      setState(() => isLastName = value)),
            ),
            Space(width: 10.h,),
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: mobileNumber,
                  label: mobileNumber,
                  controller: mobileNumberController,
                  editable: editProfile,
                  validate: isMobileNumber,
                  maxLength: 10,
                  inputFormatter: InputFieldFormatter.numberFormat,
                  errorMessage: mobileNumberMessage,
                  onTextChange: (value) =>
                      setState(() => isMobileNumber = value)),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: email,
                  label: email,
                  controller: emailController,
                  inputFormatter: InputFieldFormatter.emailTextFormat,
                  editable: editProfile,
                  validate: isEmail,
                  errorMessage: emailAddressMessage,
                  onTextChange: (value) => setState(() => isEmail = value)),
            ),
            Space(width: 10.h,),
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: aadhar,
                  label: aadhar,
                  controller: aadharNumberController,
                  maxLength: 12,
                  inputFormatter: InputFieldFormatter.numberFormat,
                  editable: editProfile,
                  validate: isAadharNumber,
                  errorMessage: aadharMessage,
                  onTextChange: (value) =>
                      setState(() => isAadharNumber = value)),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: street,
                  label: street,
                  controller: streetController,
                  editable: editProfile,
                  validate: isStreet,
                  errorMessage: streetMessage,
                  onTextChange: (value) =>
                      setState(() => isStreet = value)),
            ),
            Space(width: 10.h,),
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: city,
                  label: city,
                  controller: cityController,
                  editable: editProfile,
                  validate: isCity,
                  errorMessage: cityMessage,
                  onTextChange: (value) => setState(() => isCity = value)),
            ),
            Space(width: 10.h,),
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: state,
                  label: state,
                  controller: stateController,
                  editable: editProfile,
                  validate: isState,
                  errorMessage: stateMessage,
                  onTextChange: (value) => setState(() => isState = value)),
            ),
            Space(width: 10.h,),
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: pinCode,
                  label: pinCode,
                  controller: pinCodeController,
                  editable: editProfile,
                  validate: isPinCode,
                  errorMessage: pinCodeMessage,
                  onTextChange: (value) =>
                      setState(() => isPinCode = value)),
            ),
          ],
        ),
      ],
    );
  }

  Widget mobileView(){
    return Column(
      children: [
        CustomTextField(
            hint: fistName,
            label: fistName,
            controller: firstNameController,
            editable: editProfile,
            validate: isFirstName,
            errorMessage: fistNameMessage,
            onTextChange: (value) => setState(() => isFirstName = value)),
        CustomTextField(
            hint: lastName,
            label: lastName,
            controller: lastNameController,
            editable: editProfile,
            validate: isLastName,
            errorMessage: lastNameMessage,
            onTextChange: (value) =>
                setState(() => isLastName = value)),
        CustomTextField(
            hint: mobileNumber,
            label: mobileNumber,
            controller: mobileNumberController,
            editable: editProfile,
            validate: isMobileNumber,
            maxLength: 10,
            inputFormatter: InputFieldFormatter.numberFormat,
            errorMessage: mobileNumberMessage,
            onTextChange: (value) =>
                setState(() => isMobileNumber = value)),
        CustomTextField(
            hint: email,
            label: email,
            controller: emailController,
            inputFormatter: InputFieldFormatter.emailTextFormat,
            editable: editProfile,
            validate: isEmail,
            errorMessage: emailAddressMessage,
            onTextChange: (value) => setState(() => isEmail = value)),
        CustomTextField(
            hint: aadhar,
            label: aadhar,
            controller: aadharNumberController,
            maxLength: 12,
            inputFormatter: InputFieldFormatter.numberFormat,
            editable: editProfile,
            validate: isAadharNumber,
            errorMessage: aadharMessage,
            onTextChange: (value) =>
                setState(() => isAadharNumber = value)),
        CustomTextField(
            hint: panCardNumber,
            label: panCardNumber,
            controller: panCardController,
            inputFormatter: InputFieldFormatter.panCardNumberFormat,
            maxLength: 10,
            editable: editProfile,
            validate: isValidPanCard,
            errorMessage: panCardMessage,
            onTextChange: (value) =>
                setState(() => isValidPanCard = value)),
        CustomTextField(
            hint: street,
            label: street,
            controller: streetController,
            editable: editProfile,
            validate: isStreet,
            errorMessage: streetMessage,
            onTextChange: (value) =>
                setState(() => isStreet = value)),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: city,
                  label: city,
                  controller: cityController,
                  editable: editProfile,
                  validate: isCity,
                  errorMessage: cityMessage,
                  onTextChange: (value) => setState(() => isCity = value)),
            ),
            Space(width: 10.h,),
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: state,
                  label: state,
                  controller: stateController,
                  editable: editProfile,
                  validate: isState,
                  errorMessage: stateMessage,
                  onTextChange: (value) => setState(() => isState = value)),
            ),
          ],
        ),
        CustomTextField(
            hint: pinCode,
            label: pinCode,
            controller: pinCodeController,
            editable: editProfile,
            validate: isPinCode,
            errorMessage: pinCodeMessage,
            onTextChange: (value) =>
                setState(() => isPinCode = value)),
      ],
    );
  }
}
