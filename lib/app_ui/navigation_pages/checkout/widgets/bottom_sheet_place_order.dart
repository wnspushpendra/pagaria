import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:webnsoft_solution/address/add_address_detail_screen.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/city_state_dropdown.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_textfield.dart';
import 'package:webnsoft_solution/app_common_widges/error_widget.dart';
import 'package:webnsoft_solution/app_common_widges/heading_text.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/location.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_state.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_message.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class PlaceOrderBottomSheet extends StatefulWidget {
  final User user;
  final String orderTotal;

  const PlaceOrderBottomSheet(
      {super.key, required this.user, required this.orderTotal});

  @override
  State<PlaceOrderBottomSheet> createState() => _PlaceOrderBottomSheetState();
}

class _PlaceOrderBottomSheetState extends State<PlaceOrderBottomSheet> {
  bool placeOrderLoading = false;
  LocationData? locationData;
  Placemark? placeMark;
  bool showAddressDetailsField = false;
  TextEditingController addressController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  String? selectedCity, selectedState;
  bool? isHouseNo, isTown, isAddress, isCity, isState, isPinCode, isLandmark;
  User?  user;

  final Razorpay _razorpay = Razorpay();


  @override
  void initState() {
    super.initState();
    getDistributorDetails();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if(user!.roleId == '4'){
      submitOrderRequest('4');
    }else if(user!.roleId == '5'){
      submitOrderRequest('5');
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    snackBar(context,response.message.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  makePayment(Razorpay razorpay, String amount) async{
    User user = await getUserPref(userProfileDataPrefecences);
    var options = {
      'key': 'rzp_test_X8hH8VVR92Ya21',
      'amount': int.parse(amount)*100,
      'name': user.fullName,
      'description': 'Pagaria Customer Order Payment',
      'prefill': {
        'contact': user.contactNo,
        'email': user.email
      }
    };

    razorpay.open(options);
  }

  // razorpay payment close






  getDistributorDetails() async {
    if (widget.user.roleId == '4') {
      checkLocation();
    }
    setUserData();
    // showAddressDetailsField = showAddressValidate(widget.user);
  }

  checkLocation() async {
   // AddAddressDetailScreen();
    locationData = await checkLocationPermission();
    placeMark = await getAddressFromLatLng(locationData!);
    setState(() {});
  }

  setUserData() {
    houseNoController.text = widget.user.houseNumber ?? '';
    townController.text = widget.user.town ?? '';
    addressController.text = widget.user.address ?? '';
    selectedState = widget.user.state;
    if (selectedState != null && selectedState!.isNotEmpty) {
      selectedCity = widget.user.city;
    }
    pinCodeController.text = widget.user.zipCode ?? '';
    landmarkController.text = widget.user.landmark ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderLoading) {
          setState(() => placeOrderLoading = true);
        }
        if (state is OrderSubmitSuccess) {
          ChangeRoutes.openOrderScreen(context, true);
        }
        if (state is OrderError) {
          placeOrderLoading = false;
          if (state.error != null) {
            snackBar(context, state.error!);
          }
          orderErrorState(state);
          setState(() {});
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const BodyText(
                        text: 'Order Details',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                  const Space(
                    height: 8,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                          hint: houseNo,
                          label: houseNo,
                          controller: houseNoController,
                          validate: isHouseNo,
                          errorMessage: houseNoMessage,
                          onTextChange: (value) =>
                              setState(() => isHouseNo = value)),
                      CustomTextField(
                          hint: town,
                          label: town,
                          controller: townController,
                          validate: isTown,
                          errorMessage: townMessage,
                          onTextChange: (value) =>
                              setState(() => isTown = value)),
                      CustomTextField(
                          hint: street,
                          label: street,
                          controller: addressController,
                          validate: isAddress,
                          errorMessage: streetMessage,
                          onTextChange: (value) =>
                              setState(() => isAddress = value)),
                      CityStateDropdown(
                        selectedState: selectedState,
                        onChangeState: (value) {
                          selectedCity = null;
                          selectedState = value;
                          isState = false;
                          setState(() {});
                        },
                        selectedCity: selectedCity,
                        onChangeCity: (value) {
                          selectedCity = value;
                          isCity = false;
                          setState(() {});
                        },
                      ),
                      isState == null || isState == false
                          ? const SizedBox.shrink()
                          : CustomErrorWidget(
                              validate: !isState!, errorMessage: stateMessage),
                      if (isState == false)
                        isCity == null || isCity == false
                            ? const SizedBox.shrink()
                            : CustomErrorWidget(
                                validate: !isCity!, errorMessage: cityMessage),
                      CustomTextField(
                          hint: landmark,
                          label: landmark,
                          controller: landmarkController,
                          validate: isLandmark,
                          errorMessage: landmarkMessage,
                          onTextChange: (value) =>
                              setState(() => isLandmark = value)),
                      CustomTextField(
                          hint: pinCode,
                          label: pinCode,
                          controller: pinCodeController,
                          inputFormatter: InputFieldFormatter.numberFormat,
                          maxLength: 6,
                          isMobile: true,
                          validate: isPinCode,
                          errorMessage: pinCodeMessage,
                          onTextChange: (value) =>
                              setState(() => isPinCode = value)),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12.h),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.h),
                    decoration: defaultDecoration,
                    child: Row(
                      children: [
                        NormalText(
                          text: 'Total Payable :',
                          textSize: 18.h,
                          color: bodyBlack,
                        ),
                        Space(
                          width: 5.h,
                        ),
                        HeadingText(
                            text: "$rupeesSymbol ${widget.orderTotal}",
                            fontSize: 22.h),
                      ],
                    ),
                  ),
                  CustomButton(
                      buttonWidth: MediaQuery.of(context).size.width,
                      buttonText: 'Place Order',
                      radius: 0,
                      margin: 0,
                      showLoading: placeOrderLoading,
                      onClick: () async {
                        user = await getUser();
                        locationData = await checkLocationPermission();
                        placeMark = await getAddressFromLatLng(locationData!);
                        bool validateAddress = OrderBloc().validateDistributorAddress(OrderSubmitEvent(distributorId: widget.user.id.toString(), totalAmount: widget.orderTotal, locationData: user!.roleId == '4' ? locationData! : null, placeMark: user!.roleId == '4' ? placeMark! : null, pinCode: pinCodeController.text, houseNo: houseNoController.text, town: townController.text, address: addressController.text, city: selectedState, state: selectedCity, landMark: landmarkController.text));
                        if(!validateAddress){
                          submitOrderRequest(user!.roleId.toString());
                        }else{
                          if (user!.roleId == '4') {
                          placeOrderLoading = true;
                          setState(() {});

                          locationData != null ? makePayment(_razorpay, widget.orderTotal)  : checkLocation();
                        } else {
                          makePayment(_razorpay, widget.orderTotal);                        }
                      }}
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  submitOrderRequest(String userRole) {
    placeOrderLoading = true;
    setState(() {});
    context.read<OrderBloc>().add(OrderSubmitEvent(
        distributorId: widget.user.id.toString(),
        totalAmount: widget.orderTotal,
        locationData: userRole == '4' ? locationData! : null,
        placeMark: userRole == '4' ? placeMark! : null,
        pinCode: pinCodeController.text,
        houseNo: houseNoController.text,
        town: townController.text,
        address: addressController.text,
        city: selectedState,
        state: selectedCity,
        landMark: landmarkController.text));
  }

  bool showAddressValidate(User user) {
    return user.zipCode == null ||
        user.zipCode!.isEmpty ||
        user.city == null ||
        user.city!.isEmpty ||
        user.state == null ||
        user.state == null ||
        user.state!.isEmpty ||
        user.address == null ||
        user.address!.isEmpty;
  }

  void orderErrorState(OrderError state) {
    isHouseNo = state.houseNo;
    isTown = state.town;
    isAddress = state.address;
    isCity = state.city;
    isState = state.state;
    isPinCode = state.zipCode;
    isLandmark = state.landmark;
  }
}


