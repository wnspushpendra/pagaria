import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/city_state_dropdown.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_message.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class AddAddressDetailScreen extends StatefulWidget {

  @override
  State<AddAddressDetailScreen> createState() => _AddAddressDetailScreenState();
}

class _AddAddressDetailScreenState extends State<AddAddressDetailScreen> {
  TextEditingController addressController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  String? selectedCity, selectedState;
  bool?  isHouseNo, isTown, isAddress, isCity, isState, isPinCode, isLandmark;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      onPopInvoked : (didPop) async{
        ChangeRoutes.openHomeScreen(context, await getUser());},
      child: Scaffold(
      appBar:   AppBar(
          leading: IconButton(
            onPressed: () async =>  ChangeRoutes.openHomeScreen(context, await getUser()),
            icon: const Icon(Icons.arrow_back_ios_new,),
            color: bodyWhite,
          ),
          title:  const BodyText(
            text:  'Add Address Detailz' ,
            color: bodyWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        body:  Container(
          padding: EdgeInsets.all( 12.h),
          alignment: Alignment.center,
          child: ListView(
            children: [
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
          ),
        ),
      ),
    );
  }

  addAddressClick() {

  }




}
