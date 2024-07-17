import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webnsoft_solution/app_common_widges/aadhar_card_number_formatter.dart';
import 'package:webnsoft_solution/app_common_widges/city_state_dropdown.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/error_widget.dart';
import 'package:webnsoft_solution/app_common_widges/gst_number_text_field.dart';
import 'package:webnsoft_solution/app_common_widges/pancard_text_field.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/gender_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/bloc/profile_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/bloc/profile_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile_image_widget.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/bloc/profile_state.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/profile_detail.dart';
import 'package:webnsoft_solution/utils/app_message.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({required this.user, super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController firmNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController aadharNumberController = TextEditingController();
  TextEditingController panCardController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();

  bool? isFirstName,
      isFirmName,
      isLastName,
      isMobileNumber,
      isEmail,
      isDob,
      isAadharNumber,
      isValidPanCard,
      isValidGstNumber,
      isGender,
      isHouseNo,
      isTown,
      isStreet,
      isCity,
      isState,
      isPinCode,
      isLandmark;
  bool editProfile = false, isLoading = false, isNewImage = false;
  String genderValue = '';
  late File file;
  String path = '';
  String networkFile = '', showGender = '';
  String title = 'My Profile', selectedDate = '';
  Profile user = Profile();
  bool profileLoading = true;
  String? selectedCity, selectedState;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileFetchEvent());
    //  setProfileData();
  }

  setProfileData(Profile user) {
    String aadharNumber = user.aadharNo == null ? 'NA' : user.aadharNo!;
    String pinCode = user.zipCode == null ? 'NA' : user.zipCode!;
    fullNameController.text = user.fullName ?? 'NA';
    firmNameController.text = user.firmName ?? 'NA';
    mobileNumberController.text = user.contactNo ?? 'NA';
    emailController.text = user.email ?? 'NA';
    dobController.text = user.dateOfBirth ?? 'NA';
    aadharNumberController.text = aadharNumber;
    panCardController.text = user.panCardNo ?? 'NA';
    gstNumberController.text = user.gstNo ?? 'NA';
    houseNoController.text = user.houseNo ?? 'NA';
    townController.text = user.houseNo ?? 'NA';
    landmarkController.text = user.houseNo ?? 'NA';
    addressController.text = user.address ?? 'NA';
    addressController.text = user.address ?? 'NA';
    cityController.text = user.city ?? 'NA';
    stateController.text = user.state ?? 'NA';
    selectedCity = user.city;
    selectedState = user.state;
    pinCodeController.text = pinCode ?? 'NA';
    networkFile = user.profileImageUrl ?? 'NA';
    genderValue = user.gender ?? 'NA';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked : (didPop){
        if (editProfile) {
          setState(() {
            editProfile = false;
            title = 'My Profile';
          });
        } else {
          backUserHome(context);
        }      },
      child: Scaffold(
        appBar: appBarWidget(context, title, () async {
          if (editProfile) {
            setState(() {
              editProfile = false;
              title = 'My Profile';
            });
          } else {
            backUserHome(context);
          }
        }),
        body: /*profileLoading ? const Center(
          child: CustomProgressBar(),
        ) :*/
            BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, profileState) {
            print(profileState);

            /// * profile fetch  loading state
            if (profileState is ProfileFetchLoading) {
              setState(() => profileLoading = true);
            }

            /// * profile fetch data  state
            if (profileState is ProfileFetchSuccess) {
              profileLoading = false;
              user = profileState.user;
              setProfileData(user);
              setState(() {});
            }

            /// * profile loading state
            if (profileState is ProfileLoading) {
              setState(() => isLoading = true);
            }

            /// * profile success state
            if (profileState is ProfileSuccess) {
              cityController.text = selectedCity ?? 'NA';
              stateController.text = selectedState ?? 'NA';
              title = 'My Profile';
              setState(() {
                isLoading = false;
                editProfile = false;
              });
              snackBar(context, profileState.message);
            }
            if (profileState is ProfileError) {
              ChangeRoutes.unAuthorizedError(context, profileState.errorMessage);
              updateProfileErrorState(profileState);
              setState((){});
            }
          },
          builder: (context, profileState) {
            /// * show profile ui
            return profileLoading
                ? const Center(
                    child: CustomProgressBar(),
                  )
                : SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// * select image from gallery oro capture image
                          ProfileImageWidget(
                            showIcon: editProfile ? true : false,
                            onFileChange: (XFile value) {
                              setState(() {
                                isNewImage = true;
                                networkFile = '';
                                file = File(value.path);
                                path = value.path;
                              });
                            },
                            networkUrl: user.profileImageUrl != null
                                ? user.profileImageUrl!
                                : '',
                          ),

                          const Space(
                            height: 18,
                          ),

                          mobileView(),
                          CustomButton(
                              buttonText:
                                  editProfile == false ? 'Edit' : 'Update',
                              showLoading:
                                  editProfile == true ? isLoading : false,

                              /// * perform action should be update or in update state
                              onClick: () => profileButtonClick())
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
      children: [
        CustomTextField(
            hint: fullName,
            label: fullName,
            controller: fullNameController,
            editable: editProfile,
            validate: isFirstName,
            errorMessage: fullNameMessage,
            onTextChange: (value) => setState(() => isFirstName = value)),
        if (widget.user.roleId! == '5')
          CustomTextField(
              hint: firmName,
              label: firmName,
              controller: firmNameController,
              editable: editProfile,
              validate: isFirmName,
              errorMessage: firmNameMessage,
              onTextChange: (value) => setState(() => isFirmName = value)),
        CustomTextField(
            hint: mobileNumber,
            label: mobileNumber,
            controller: mobileNumberController,
            editable: editProfile,
            validate: isMobileNumber,
            maxLength: 10,
            inputFormatter: InputFieldFormatter.numberFormat,
            errorMessage: mobileNumberMessage,
            onTextChange: (value) => setState(() => isMobileNumber = value)),
        CustomTextField(
            hint: email,
            label: email,
            controller: emailController,
            inputFormatter: InputFieldFormatter.emailTextFormat,
            editable: false,
            validate: isEmail,
            errorMessage: emailAddressMessage,
            onTextChange: (value) => setState(() => isEmail = value)),
        GestureDetector(
          onTap: () {
            if (editProfile) {
              /// * select date for dob
              selectDate(context).then((value) => dobController.text = value);
            }
          },
          child: CustomTextField(
              hint: dob,
              label: dob,
              controller: dobController,
              editable: false,
              validate: isDob,
              icon: const Icon(Icons.calendar_month),
              errorMessage: dobMessage,
              onTextChange: (value) => setState(() => isDob = value)),
        ),

        /// * gender selection
        SelectGender(
          gender: genderValue,
          onChange: (String value) => setState(() {
            if (editProfile) {
              genderValue = value;
            }
          }),
        ),
        if (widget.user.roleId! == '5')
          CustomTextField(
              hint: aadhar,
              label: aadhar,
              controller: aadharNumberController,
              maxLength: 14,
              inputFormatter: [AadhaarNumberFormatter()],
              isMobile: true,
              editable: editProfile,
              validate: isAadharNumber,
            //  errorMessage: aadharMessage,
              onTextChange: (value) => setState(() => isAadharNumber = value)),
        if (widget.user.roleId! == '5')
          CustomPanCardField(
              controller: panCardController,
              editable: editProfile,
              validate: isValidPanCard,
             // errorMessage: panCardMessage,
              onTextChange: (value) => setState(() => isValidPanCard = value)),
   if (widget.user.roleId! == '5')
     CustomerGstNumberTextField(
         controller: gstNumberController,
         editable: editProfile,
         validate: isValidGstNumber,
         errorMessage: gstNumberMessage,
         onTextChange: (value) => setState(() => isValidGstNumber = value)),
        if (widget.user.roleId! == '5')

        CustomTextField(
            hint: houseNo,
            label: houseNo,
            controller: houseNoController,
            editable: editProfile,
            validate: isHouseNo,
          //  errorMessage: houseNoMessage,
            onTextChange: (value) => setState(() => isHouseNo = value)),
        if (widget.user.roleId! == '5')
          CustomTextField(
            hint: town,
            label: town,
            controller: townController,
            editable: editProfile,
            validate: isTown,
           // errorMessage: townMessage,
            onTextChange: (value) => setState(() => isTown = value)),
        CustomTextField(
            hint: street,
            label: street,
            controller: addressController,
            editable: editProfile,
            validate: isStreet,
          //  errorMessage: streetMessage,
            onTextChange: (value) => setState(() => isStreet = value)),

        !editProfile
            ? Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextField(
                        hint: state,
                        label: state,
                        controller: stateController,
                        editable: editProfile,
                        validate: isState,
                       // errorMessage: stateMessage,
                        onTextChange: (value) =>
                            setState(() => isState = value)),
                  ),
                  Space(
                    width: 10.h,
                  ),
                  Expanded(
                    flex: 1,
                    child: CustomTextField(
                        hint: city,
                        label: city,
                        controller: cityController,
                        editable: editProfile,
                        validate: isCity,
                      //  errorMessage: cityMessage,
                        onTextChange: (value) =>
                            setState(() => isCity = value)),
                  ),
                ],
              )
            : CityStateDropdown(
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
            hint: pinCode,
            label: pinCode,
            controller: pinCodeController,
            editable: editProfile,
            inputFormatter: InputFieldFormatter.numberFormat,
            validate: isPinCode,
            maxLength: 6,
            isMobile: true,
           errorMessage: pinCodeMessage, onTextChange: (value) => setState(() => isPinCode = value)
        ),
        if (widget.user.roleId! == '5')
          CustomTextField(
            hint: landmark,
            label: landmark,
            controller: landmarkController,
            editable: editProfile,
            //validate: isLandmark,
            errorMessage: landmarkMessage,
            onTextChange: (value) => setState(() => isLandmark = value)),
      ],
    );
  }

  profileButtonClick() {
    /// * checking profile action for perform  is in showing or update
    if (editProfile) {
      path = path.isEmpty ? widget.user.profileImageUrl.toString() : path;
      if (widget.user.roleId == "4") {
        /// * update marketing executive event calling
        context.read<ProfileBloc>().add(ProfileUpdateClickEvent(
            fullName: fullNameController.text,
            mobileNumber: mobileNumberController.text,
            email: emailController.text,
            houseNo: houseNoController.text,
            town: townController.text,
            address: addressController.text,
            city: selectedCity!,
            state: selectedState!,
            landmark: landmarkController.text,
            pinCode: pinCodeController.text,
            gender: genderValue,
            path: path,
            dob: dobController.text,
            isNewImage: isNewImage));
      } else {
        /// * update distributor event calling

        context.read<ProfileBloc>().add(ProfileUpdateClickEvent(
            fullName: fullNameController.text,
            firmName: firmNameController.text,
            mobileNumber: mobileNumberController.text,
            email: emailController.text,
            aadhaarNumber: aadharNumberController.text,
            panNumber: panCardController.text,
            houseNo: houseNoController.text,
            town: townController.text,
            address: addressController.text,
            gstNumber: gstNumberController.text,
            city: selectedCity ?? '',
            state: selectedState ?? '',
            landmark: landmarkController.text,
            pinCode: pinCodeController.text,
            gender: genderValue,
            path: path,
            dob: dobController.text,
            isNewImage: isNewImage));
      }
    }
    setState(() {
      /// * check for ui state profile showing or updating
      if (!editProfile) {
        setState(() {
          editProfile = true;
          title = 'Update Profile';
        });
      }
    });
  }

  /// * profile update error

  updateProfileErrorState(ProfileError profileState) {
    isFirstName = profileState.fullName;
    isMobileNumber = profileState.mobileNumber;
    isEmail = profileState.email;
    isAadharNumber = profileState.aadhaarNumber;
    isValidPanCard = profileState.panNumber;
    isValidGstNumber = profileState.gst;
    isStreet = profileState.address;
    isCity = profileState.city;
    isState = profileState.state;
    isPinCode = profileState.pinCode;
    isGender = profileState.gender;

  }
}
