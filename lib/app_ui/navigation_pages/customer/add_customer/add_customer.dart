import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/error_widget.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/add_customer/bloc/add_customer_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/add_customer/bloc/add_customer_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/add_customer/bloc/add_customer_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/gender_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile_image_widget.dart';
import 'package:webnsoft_solution/modal/login/MarketingExecutiveLoginResponse.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_message.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController firmNameController = TextEditingController();
  TextEditingController aadharCardController = TextEditingController();
  TextEditingController panCardController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  bool? isFullName, isMobileNumber, isEmail,isDob,isGender,isFirmName,isPanCardNumber,isAadharNumber,isGstNumber, isAddress, isCity, isState, isPinCode,isProfileImage;
  String genderValue = '',path = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          context, 'Add Distributor', () async{
            User user = await getUserPref(userProfileDataPrefecences);
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushReplacementNamed(context, homeRoute,arguments: user);
            });
      }),
      body: BlocConsumer<AddCustomerBloc, AddCustomerState>(
        listener: (context, addCustomerState) async{
          User user = await getUserPref(userProfileDataPrefecences);
          if (addCustomerState is AddCustomerError)  {
            setState(() => updateErrorUi(addCustomerState));
          }
          if (addCustomerState is AddCustomerSuccess)  {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushReplacementNamed(context, homeRoute,arguments: user);
            });
          }
        },
        builder: (context, addCustomerState) {
          if (addCustomerState is AddCustomerLoading) {
            return const CustomProgressBar();
          }
          var width = MediaQuery.of(context).size.width;
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                   ProfileImageWidget(onFileChange: (XFile value) => setState((){
                     path = value.path;
                     isProfileImage = !isProfileImage!;
                   }), networkUrl: '',),
                  isProfileImage == null || isProfileImage == false ? const SizedBox.shrink() : CustomErrorWidget(validate: !isProfileImage! , errorMessage: profileImageMessage),
                  const Space(height: 2,),
                  mobileView(),
                  CustomButton(buttonText: 'Add', onClick: () {
                    addDistributor();
                  })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  addDistributor() {
    context.read<AddCustomerBloc>().add(AddDistributorClickEvent(
        fullName: fullNameController.text, mobileNumber: mobileNumberController.text, email: emailController.text, 
        dob: dobController.text, gender: genderValue, firmName: firmNameController.text, aadharNumber: aadharCardController.text,
        panCardNumber: panCardController.text, gstNumber: gstNumberController.text, address: addressController.text,
        city: cityController.text, state: stateController.text, pinCode: pinCodeController.text,
        profileImage: path));
  }

  void updateErrorUi(AddCustomerError addCustomerState) {
    isFullName = addCustomerState.name;
    isMobileNumber = addCustomerState.mobileNumber;
    isEmail = addCustomerState.email;
    isDob = addCustomerState.dob;
    isGender = addCustomerState.gender;
    isFirmName = addCustomerState.firmName;
    isAadharNumber = addCustomerState.aadharNumber;
    isPanCardNumber = addCustomerState.panCardNumber;
    isAddress = addCustomerState.address;
    isCity = addCustomerState.city;
    isState = addCustomerState.state;
    isPinCode = addCustomerState.pinCode;
    isProfileImage = addCustomerState.profileImage;
  }

  Widget mobileView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
            hint: fullName,
            label: fullName,
            controller: fullNameController,
            validate: isFullName,
            errorMessage: fullNameMessage,
            onTextChange: (value) => setState(() => isFullName = value)),
        CustomTextField(
            hint: "$mobileNumber*",
            label: "$mobileNumber*",
            controller: mobileNumberController,
            validate: isMobileNumber,
            errorMessage: mobileNumberMessage,
            onTextChange: (value) => setState(() => isMobileNumber = value)),
        CustomTextField(
            hint: "$email*",
            label: "$email*",
            controller: emailController,
            validate: isEmail,
            errorMessage: emailAddressMessage,
            onTextChange: (value) => setState(() => isEmail = value)),
        GestureDetector(
          onTap: (){
            var date =  selectDate(context).then((value) => print(value));
            print(date);
          },
          child: CustomTextField(
              hint: "$dob*",
              label: "$dob*",
              controller: dobController,
              validate: isDob,
              icon: const Icon(Icons.calendar_month),
              errorMessage: dobMessage,
              onTextChange: (value) => setState(() => isDob = value)),
        ),
        const BodyText(text: 'Select Gender',fontSize: 14,),
        SelectGender(gender: genderValue, onChange: (String value) => setState(() {
            genderValue = value;
          }
        ),),
        isGender == null || isGender == false ? const SizedBox.shrink() : CustomErrorWidget(validate: !isGender! , errorMessage: genderMessage),
        const Space(height: 2,),
        CustomTextField(
            hint: "$firmName*",
            label: "$firmName*",
            controller: firmNameController,
            validate: isFirmName,
            errorMessage: firmNameMessage,
            onTextChange: (value) => setState(() => isFirmName = value)),
        CustomTextField(
            hint: "$aadharNumber*",
            label: "$aadharNumber*",
            controller: aadharCardController,
            inputFormatter: InputFieldFormatter.numberFormat,
            maxLength: 12,
            validate: isAadharNumber,
            errorMessage: aadharMessage,
            onTextChange: (value) => setState(() => isAadharNumber = value)),
        CustomTextField(
            hint: "$panCardNumber*",
            label: "$panCardNumber*",
            controller: panCardController,
            maxLength: 10,
            validate: isPanCardNumber,
            errorMessage: panCardNumber,
            onTextChange: (value) => setState(() => isPanCardNumber = value)),
        CustomTextField(
            hint: "$gstNumber*",
            label: "$gstNumber*",
            controller: gstNumberController,
            validate: isGstNumber,
            errorMessage: gstNumberMessage,
            onTextChange: (value) => setState(() => isGstNumber = value)),
        CustomTextField(
            hint: "$street*",
            label: "$street*",
            controller: addressController,
            validate: isAddress,
            errorMessage: streetMessage,
            onTextChange: (value) => setState(() => isAddress = value)),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: "$city*",
                  label: "$city*",
                  controller: cityController,
                  validate: isCity,
                  errorMessage: cityMessage,
                  onTextChange: (value) => setState(() => isCity = value)),
            ),
            Space(
              width: 8.h,
            ),
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: "$state*",
                  label: "$state*",
                  controller: stateController,
                  validate: isState,
                  errorMessage: stateMessage,
                  onTextChange: (value) => setState(() => isState = value)),
            ),
          ],
        ),
        CustomTextField(
            hint: "$pinCode*",
            label: "$pinCode*",
            controller: pinCodeController,
            inputFormatter: InputFieldFormatter.numberFormat,
            maxLength: 6,
            validate: isPinCode,
            errorMessage: pinCodeMessage,
            onTextChange: (value) => setState(() => isPinCode = value)),
      ],
    );
  }
}



