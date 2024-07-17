import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webnsoft_solution/app_common_widges/aadhar_card_number_formatter.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/city_state_dropdown.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/error_widget.dart';
import 'package:webnsoft_solution/app_common_widges/gst_number_text_field.dart';
import 'package:webnsoft_solution/app_common_widges/pancard_text_field.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/add_customer/bloc/add_customer_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/add_customer/bloc/add_customer_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/add_customer/bloc/add_customer_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/gender_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile_image_widget.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_message.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
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
  TextEditingController houseNoController = TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  bool? isFullName,
      isMobileNumber,
      isEmail,
      isDob,
      isGender,
      isFirmName,
      isPanCardNumber,
      isAadharNumber,
      isGstNumber,
      isHouseNo,
      isTown,
      isAddress,
      isCity,
      isState,
      isPinCode,
      isLandmark,
      isProfileImage;
  String genderValue = '', path = '';
  bool showLoading = false;
  String? selectedCity, selectedState;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked : (didPop) async => ChangeRoutes.openHomeScreen(context, await getUser()),
      child: Scaffold(
        appBar: appBarWidget(context, 'Add Customer', () async => ChangeRoutes.openHomeScreen(context, await getUser())),
        body: BlocConsumer<AddCustomerBloc, AddCustomerState>(
          listener: (context, addCustomerState) {
            /***************** add distributor/customer loading state ****************/
            if (addCustomerState is AddCustomerLoading) {
              setState(() => showLoading = !showLoading);
            }
            /***************** add distributor/customer error state ****************/
            if (addCustomerState is AddCustomerError) {
              if (addCustomerState.message == 'unauthorization') {
                backToLogin(context);
              }
              showLoading = false;
              if (addCustomerState.message != null) {
                snackBar(context, addCustomerState.message.toString());
              }
              updateErrorUi(addCustomerState);
              setState(() {});
            }
            /***************** add distributor/customer success state ****************/
            if (addCustomerState is AddCustomerSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                Navigator.pushReplacementNamed(context, homeRoute,
                    arguments: await getUser());
              });
            }
          },
          builder: (context, addCustomerState) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    ProfileImageWidget(
                      onFileChange: (XFile value) => setState(() {
                        path = value.path;
                        isProfileImage = false;
                      }),
                      networkUrl: '',
                    ),
                    isProfileImage == null || isProfileImage == false
                        ? const SizedBox.shrink()
                        : CustomErrorWidget(
                            validate: !isProfileImage!,
                            errorMessage: profileImageMessage),
                    Space(
                      height: 20.h,
                    ),
                    mobileView(),
                    CustomButton(
                        buttonText: 'Add',
                        showLoading: showLoading,
                        onClick: () => addDistributor())
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
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
            inputFormatter: InputFieldFormatter.numberFormat,
            maxLength: 10,
            isMobile: true,
            controller: mobileNumberController,
            validate: isMobileNumber,
            errorMessage: mobileNumberMessage,
            onTextChange: (value) => setState(() => isMobileNumber = value)),
        CustomTextField(
            hint: "$email*",
            label: "$email*",
            inputFormatter: InputFieldFormatter.emailTextFormat,
            controller: emailController,
            validate: isEmail,
            errorMessage: emailAddressMessage,
            onTextChange: (value) => setState(() => isEmail = value)),
        GestureDetector(
          onTap: () {
            selectDate(context).then((value) {
              dobController.text = value;
              isDob = false;
              setState(() {});
            });
          },
          child: CustomTextField(
              hint: "$dob*",
              label: "$dob*",
              controller: dobController,
              validate: isDob,
              editable: false,
              icon: const Icon(Icons.calendar_month),
              errorMessage: dobMessage,
              onTextChange: (value) => setState(() => isDob = value)),
        ),
        const BodyText(
          text: 'Select Gender *',
          fontSize: 14,
        ),
        SelectGender(
          gender: genderValue,
          onChange: (String value) => setState(() {
            isGender = false;
            genderValue = value;
          }),
        ),
        isGender == null || isGender == false
            ? const SizedBox.shrink()
            : CustomErrorWidget(
                validate: !isGender!, errorMessage: genderMessage),
        const Space(
          height: 2,
        ),
        CustomTextField(
            hint: "$firmName*",
            label: "$firmName*",
            controller: firmNameController,
            validate: isFirmName,
            errorMessage: firmNameMessage,
            onTextChange: (value) => setState(() => isFirmName = value)),
        CustomTextField(
            hint: aadharNumber,
            label: aadharNumber,
            controller: aadharCardController,
            inputFormatter: [AadhaarNumberFormatter()],
            maxLength: 14,
            isMobile: true,
            validate: isAadharNumber,
            errorMessage: aadharMessage,
            onTextChange: (value) => setState(() => isAadharNumber = value)),
        CustomPanCardField(
            controller: panCardController,
            validate: isPanCardNumber,
            errorMessage: panCardMessage,
            onTextChange: (value) => setState(() => isPanCardNumber = value)),
        CustomerGstNumberTextField(
            controller: gstNumberController,
            validate: isGstNumber,
            errorMessage: gstNumberMessage,
            onTextChange: (value) => setState(() => isGstNumber = value)),
        CustomTextField(
            hint: houseNo,
            label: houseNo,
            controller: houseNoController,
            validate: isHouseNo,
            errorMessage: houseNoMessage,
            onTextChange: (value) => setState(() => isHouseNo = value)),
        CustomTextField(
            hint: town,
            label: town,
            controller: townController,
            validate: isTown,
            errorMessage: townMessage,
            onTextChange: (value) => setState(() => isTown = value)),
        CustomTextField(
            hint: street,
            label: street,
            controller: addressController,
            validate: isAddress,
            errorMessage: streetMessage,
            onTextChange: (value) => setState(() => isAddress = value)),
      CityStateDropdown(
          selectedState: selectedState,
          onChangeState: (value) {
            selectedCity = null;
            selectedState = value;
          },
          selectedCity: selectedCity,
          onChangeCity: (value) {
            selectedCity = value;
          },
        ),
        CustomTextField(
            hint: landmark,
            label: landmark,
            controller: landmarkController,
            validate: isLandmark,
            errorMessage: landmarkMessage,
            onTextChange: (value) => setState(() => isLandmark = value)),
        CustomTextField(
            hint: pinCode,
            label: pinCode,
            controller: pinCodeController,
            inputFormatter: InputFieldFormatter.numberFormat,
            maxLength: 6,
            isMobile: true,
            validate: isPinCode,
            errorMessage: pinCodeMessage,
            onTextChange: (value) => setState(() => isPinCode = value)),
     ],
    );
  }

  addDistributor() {
    /***************** call api and validate for distributor ****************/
    context.read<AddCustomerBloc>().add(AddDistributorClickEvent(
        fullName: fullNameController.text,
        mobileNumber: mobileNumberController.text,
        email: emailController.text,
        dob: dobController.text,
        gender: genderValue,
        firmName: firmNameController.text,
        aadharNumber: aadharCardController.text,
        panCardNumber: panCardController.text,
        gstNumber: gstNumberController.text,
        houseNo: houseNoController.text,
        town: townController.text,
        address: addressController.text,
        city: selectedCity,
        state: selectedState,
        pinCode: pinCodeController.text,
        landmark: landmarkController.text,
        profileImage: path));
  }

  void updateErrorUi(AddCustomerError addCustomerState) {
    isFullName = addCustomerState.name;
    isMobileNumber = addCustomerState.mobileNumber;
    isEmail = addCustomerState.email;
    isDob = addCustomerState.dob;
    isGender = addCustomerState.gender;
    isFirmName = addCustomerState.firmName;
   // isAadharNumber = addCustomerState.aadharNumber;
   // isPanCardNumber = addCustomerState.panCardNumber;
   // isGstNumber = addCustomerState.gstNumber;
   // isAddress = addCustomerState.address;
   // isCity = addCustomerState.city;
   // isState = addCustomerState.state;
   // isPinCode = addCustomerState.pinCode;
  //  isProfileImage = addCustomerState.profileImage;
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    aadharCardController.dispose();
    panCardController.dispose();
    gstNumberController.dispose();
    dobController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    pinCodeController.dispose();
    super.dispose();
  }
}
