import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/gender_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/bloc/profile_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/bloc/profile_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile_image_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/bloc/profile_state.dart';
import 'package:webnsoft_solution/modal/login/MarketingExecutiveLoginResponse.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_message.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({required this.user,super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController aadharNumberController = TextEditingController();
  TextEditingController panCardController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  bool? isFirstName, isLastName, isMobileNumber, isEmail, isDob, isAadharNumber,isValidPanCard, isGender, isStreet, isCity, isState, isPinCode;
  bool editProfile = false;
   bool isLoading = false;
  String genderValue = '';
  late File file;
  String path =  '';
  String networkFile = '',showGender = '';
  String selectedDate = '';

  @override
  void initState() {
    super.initState();
    setProfileData();
  }

  setProfileData(){
    String aadharNumber = widget.user.aadharNo == null ?'': widget.user.aadharNo!;
    String pinCode = widget.user.zipCode == null ? '' :widget.user.zipCode!;
    fullNameController.text = widget.user.fullName??'';
    mobileNumberController.text = widget.user.contactNo??'';
    emailController.text = widget.user.email??'';
   // dobController.text = widget.user.dob??'';
    aadharNumberController.text = aadharNumber;
    panCardController.text = widget.user.panCardNo??'';
    addressController.text = widget.user.address??'';
    cityController.text = widget.user.city??'';
    stateController.text = widget.user.state??'';
    pinCodeController.text = pinCode;
    networkFile = widget.user.profileImageUrl??'';
    genderValue = widget.user.gender ?? '';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, 'Profile', () async{
        if(editProfile){
          setState(() => editProfile = false);
        }else{
            Navigator.pushReplacementNamed(context, homeRoute,arguments: await getUser());
        }
      }),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, profileState) {
          if(state is ProfileLoading){
            setState(() => isLoading = true);
          }
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
                   ProfileImageWidget(
                     onFileChange: (XFile value) {
                       setState(() {
                         networkFile = '';
                         file = File(value.path);
                         path = value.path;
                         print(path);
                       });
                     },
                     networkUrl: networkFile,),

                 const Space(height: 8,),
                  mobileView(),
                  CustomButton(
                      buttonText: editProfile == false? 'Edit' :'Update',
                      showLoading : editProfile == true ? isLoading : false,
                      onClick: () => profileButtonClick())
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget mobileView(){
    return Column(
      children: [
        CustomTextField(
            hint: fullName,
            label: fullName,
            controller: fullNameController,
            editable: editProfile,
            validate: isFirstName,
            errorMessage: fullNameMessage,
            onTextChange: (value) => setState(() => isFirstName = value)),
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
        GestureDetector(
          onTap: (){
           var date =  selectDate(context).then((value) => print(value));
           print(date);
          },
          child: CustomTextField(
              hint: dob,
              label: dob,
              controller: dobController,
              editable: editProfile,
              validate: isDob,
              icon: const Icon(Icons.calendar_month),
              errorMessage: dobMessage,
              onTextChange: (value) => setState(() => isDob = value)),
        ),
        SelectGender(gender: genderValue, onChange: (String value) => setState(() {
          if(editProfile){
            genderValue = value;
          }
        }),),
        if(widget.user == 5)
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
        if(widget.user == 5)
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
            controller: addressController,
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
  profileButtonClick() {
    if(editProfile){
     if( widget.user.roleId == "4"){
        context.read<ProfileBloc>().add(ProfileUpdateClickEvent(
          fullName: fullNameController.text,
          mobileNumber: mobileNumberController.text,
          email: emailController.text,
          address: streetController.text,
          city: cityController.text,
          state: stateController.text,
          pinCode: pinCodeController.text,
          gender: genderValue,
        path: path, dob: '',
      ));
     }

     /* context.read<ProfileBloc>().add(ProfileUpdateClickEvent(
          fullName: fullNameController.text,
          mobileNumber: mobileNumberController.text,
          email: emailController.text,
          aadharNumber: aadharNumberController.text,
          panNumber :panCardController.text,
          address: streetController.text,
          city: cityController.text,
          state: stateController.text,
          pinCode: pinCodeController.text,
          gender: genderValue,
        path: path,
      ));*/
    }
    setState(() => editProfile == false ? editProfile = true :editProfile =  false);

  }
  updateProfileErrorState(ProfileError profileState) {
    isFirstName = profileState.fullName;
    isMobileNumber = profileState.mobileNumber;
    isEmail = profileState.email;
    isAadharNumber = profileState.aadharNumber;
    isValidPanCard = profileState.panNumber;
    isStreet = profileState.address;
    isCity = profileState.city;
    isState = profileState.state;
    isPinCode = profileState.pinCode;
    isGender = profileState.gender;
  }



}
