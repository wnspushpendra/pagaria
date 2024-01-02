import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/add_customer/bloc/add_customer_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/add_customer/bloc/add_customer_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/add_customer/bloc/add_customer_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile_image_widget.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_message.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController panCardController = TextEditingController();
  TextEditingController aadharCardController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  bool? isName, isMobileNumber, isEmail,isPanCard,isAadharNumber,isGstNumber, isStreet, isCity, isState, isPinCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          context, 'Add Customer', () => onPopReplace(context, homeRoute)),
      body: BlocConsumer<AddCustomerBloc, AddCustomerState>(
        listener: (context, addCustomerState) {
          if (addCustomerState is AddCustomerError) {
            setState(() => updateErrorUi(addCustomerState));
          }
          if (addCustomerState is AddCustomerSuccess) {
            onPopReplace(context, homeRoute);
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
                   ProfileImageWidget(onFileChange: (File value) {  }, networkUrl: '',),
                 // if (width > 1200) desktopView(),
                  if (width > 600) tabletView(),
                  if (width < 400) mobileView(),
                  CustomButton(buttonText: 'Add', onClick: () => addCustomer())
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  addCustomer() {
    context.read<AddCustomerBloc>().add(AddCustomerClickEvent(
        name: nameController.text,
        mobileNumber: mobileNumberController.text,
        email: emailController.text,
        street: streetController.text,
        city: cityController.text,
        state: stateController.text,
        pinCode: pinCodeController.text));
  }

  void updateErrorUi(AddCustomerError addCustomerState) {
    isName = addCustomerState.name;
    isMobileNumber = addCustomerState.mobileNumber;
    isEmail = addCustomerState.email;
    isStreet = addCustomerState.state;
    isCity = addCustomerState.city;
    isState = addCustomerState.state;
    isPinCode = addCustomerState.pinCode;
  }

  Widget desktopView() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: name,
                  label: name,
                  controller: nameController,
                  validate: isName,
                  errorMessage: nameMessage,
                  onTextChange: (value) => setState(() => isName = value)),
            ),
            Space(width: 10.h),
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: mobileNumber,
                  label: mobileNumber,
                  controller: mobileNumberController,
                  validate: isMobileNumber,
                  errorMessage: mobileNumberMessage,
                  onTextChange: (value) =>
                      setState(() => isMobileNumber = value)),
            ),
            Space(width: 10.h),
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: email,
                  label: email,
                  controller: emailController,
                  validate: isEmail,
                  errorMessage: emailAddressMessage,
                  onTextChange: (value) => setState(() => isEmail = value)),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: CustomTextField(
                  hint: street,
                  label: street,
                  controller: streetController,
                  validate: isStreet,
                  errorMessage: streetMessage,
                  onTextChange: (value) => setState(() => isStreet = value)),
            ),
            Space(width: 10.h),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextField(
                        hint: city,
                        label: city,
                        controller: cityController,
                        validate: isCity,
                        errorMessage: cityMessage,
                        onTextChange: (value) => setState(() => isCity = value)),
                  ),
                  Space(
                    width: 10.h,
                  ),
                  Expanded(
                    flex: 1,
                    child: CustomTextField(
                        hint: state,
                        label: state,
                        controller: stateController,
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
                        validate: isPinCode,
                        errorMessage: pinCodeMessage,
                        onTextChange: (value) => setState(() => isPinCode = value)),
                  ),

                ],
              ),
            ),
        /*    Space(
              width: 10.h,
            ),
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: state,
                  label: state,
                  controller: stateController,
                  validate: isState,
                  errorMessage: stateMessage,
                  onTextChange: (value) => setState(() => isState = value)),
            ),*/
         /*   Space(width: 10.h),
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: pinCode,
                  label: pinCode,
                  controller: pinCodeController,
                  validate: isPinCode,
                  errorMessage: pinCodeMessage,
                  onTextChange: (value) => setState(() => isPinCode = value)),
            ),*/
          ],
        ),
      ],
    );
  }
  Widget tabletView() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: name,
                  label: name,
                  controller: nameController,
                  validate: isName,
                  errorMessage: nameMessage,
                  onTextChange: (value) => setState(() => isName = value)),
            ),
            Space(width: 10.h),
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: mobileNumber,
                  label: mobileNumber,
                  controller: mobileNumberController,
                  validate: isMobileNumber,
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
                  validate: isEmail,
                  errorMessage: emailAddressMessage,
                  onTextChange: (value) => setState(() => isEmail = value)),
            ),
            Space(width: 10.h),
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: street,
                  label: street,
                  controller: streetController,
                  validate: isStreet,
                  errorMessage: streetMessage,
                  onTextChange: (value) => setState(() => isStreet = value)),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: city,
                  label: city,
                  controller: cityController,
                  validate: isCity,
                  errorMessage: cityMessage,
                  onTextChange: (value) => setState(() => isCity = value)),
            ),
            Space(
              width: 10.h,
            ),
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: state,
                  label: state,
                  controller: stateController,
                  validate: isState,
                  errorMessage: stateMessage,
                  onTextChange: (value) => setState(() => isState = value)),
            ),
            Space(width: 10.h),
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: pinCode,
                  label: pinCode,
                  controller: pinCodeController,
                  validate: isPinCode,
                  errorMessage: pinCodeMessage,
                  onTextChange: (value) => setState(() => isPinCode = value)),
            ),
          ],
        ),
      ],
    );
  }

  Widget mobileView() {
    return Column(
      children: [
        CustomTextField(
            hint: name,
            label: name,
            controller: nameController,
            validate: isName,
            errorMessage: nameMessage,
            onTextChange: (value) => setState(() => isName = value)),
        CustomTextField(
            hint: mobileNumber,
            label: mobileNumber,
            controller: mobileNumberController,
            validate: isMobileNumber,
            errorMessage: mobileNumberMessage,
            onTextChange: (value) => setState(() => isMobileNumber = value)),
        CustomTextField(
            hint: email,
            label: email,
            controller: emailController,
            validate: isEmail,
            errorMessage: emailAddressMessage,
            onTextChange: (value) => setState(() => isEmail = value)),
        CustomTextField(
            hint: panCardNumber,
            label: panCardNumber,
            controller: panCardController,
            validate: isPanCard,
            errorMessage: panCardNumber,
            onTextChange: (value) => setState(() => isPanCard = value)),
        CustomTextField(
            hint: aadharNumber,
            label: aadharNumber,
            controller: aadharCardController,
            validate: isAadharNumber,
            errorMessage: aadharMessage,
            onTextChange: (value) => setState(() => isAadharNumber = value)),
        CustomTextField(
            hint: gstNumber,
            label: gstNumber,
            controller: gstNumberController,
            validate: isGstNumber,
            errorMessage: gstNumberMessage,
            onTextChange: (value) => setState(() => isGstNumber = value)),
        CustomTextField(
            hint: street,
            label: street,
            controller: streetController,
            validate: isStreet,
            errorMessage: streetMessage,
            onTextChange: (value) => setState(() => isStreet = value)),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CustomTextField(
                  hint: city,
                  label: city,
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
                  hint: state,
                  label: state,
                  controller: stateController,
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
            validate: isPinCode,
            errorMessage: pinCodeMessage,
            onTextChange: (value) => setState(() => isPinCode = value)),
      ],
    );
  }
}



