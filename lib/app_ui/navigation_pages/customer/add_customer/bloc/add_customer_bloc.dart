
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/add_customer/add_custom_api.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/add_customer/bloc/add_customer_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/add_customer/bloc/add_customer_state.dart';
import 'package:webnsoft_solution/modal/AddDistributor.dart';
import 'package:webnsoft_solution/modal/login/MarketingExecutiveLoginResponse.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/validation.dart';

class AddCustomerBloc extends Bloc<AddCustomerEvent, AddCustomerState> {
  AddCustomerBloc() : super(AddCustomerInitial()) {
    on<AddDistributorClickEvent>((event, emit) {
      bool   validate = validateDistributor(event);
      if(validate){
        addDistributorApi(event);
      }

  /*    bool fullName = false, mobileNumber = false, email = false,dob = false,gender = false,
        firmName = false,aadharNumber = false,panCardNumber = false,gstNumber = false,
          address = false,city = false, state = false, pinCode = false,profileImage = false;

      fullName = event.fullName.7isEmpty && !isNameValid(event.fullName);
      mobileNumber = event.mobileNumber.isEmpty && event.mobileNumber.length != 10  ;
      email = event.email.isEmpty && !isValidEmail(event.email) ;
      dob = event.dob.isEmpty;
      gender = event.gender.isEmpty;
      firmName = event.firmName.isEmpty;
      aadharNumber = event.aadharNumber.isEmpty && event.aadharNumber.length != 12;
      panCardNumber = event.panCardNumber.isEmpty&& event.aadharNumber.length != 10;
      gstNumber = event.gstNumber.isEmpty && !isValidateGSTNumber(event.gstNumber);
      address = event.address.isEmpty && event.aadharNumber.length <=3;
      city = event.city.isEmpty;
      state = event.state.isEmpty;
      pinCode = event.pinCode.isEmpty && event.pinCode.length != 4;
      profileImage = event.profileImage.isEmpty;
      if(!fullName && !mobileNumber && !email && !dob && !gender &&  !firmName && !aadharNumber &&
          !panCardNumber &&  !gstNumber && !address && !city && !state && !pinCode && !profileImage ){
        addDistributorApi(event);
      }else{
        emit(AddCustomerError(name: fullName, mobileNumber: mobileNumber, email: email,dob: dob,gender: gender,firmName: firmName,
          aadharNumber : aadharNumber,panCardNumber: panCardNumber,gstNumber:  gstNumber,address: address, city: city, state: state, pinCode: pinCode,profileImage: profileImage));
      }*/


    });
    on<AddCustomerClickEvent>((event, emit) {

      bool fullName = false, mobileNumber = false,email = false,dob = false,gender =false,address = false,city = false,state = false,pinCode = false,profile  = false;

      fullName = event.fullName.isEmpty && !isNameValid(event.fullName);
      mobileNumber = event.mobileNumber.isEmpty && event.mobileNumber.length != 10  ;
      email = event.email.isEmpty && !isValidEmail(event.email) ;
      dob = event.dob.isEmpty;
      gender = event.gender.isEmpty;
      city = event.city.isEmpty;
      state = event.state.isEmpty;
      pinCode = event.pinCode.isEmpty && event.pinCode.length != 4;
      profile = event.profileImage.isEmpty;
      if(!fullName && !mobileNumber && !email && !dob && !gender &&   !address && !city && !state && !pinCode && !profile ){
        addCustomerApi(event);
      }else{
        emit(AddCustomerError(name: fullName, mobileNumber: mobileNumber, email: email, address: address, city: city, state: state, pinCode: pinCode,profileImage: profile));
      }
    });
  }

  void addDistributorApi(AddDistributorClickEvent event) async {
    String token = await getStringPref(userTokenPrefecences);
    User user = await getUserPref(userProfileDataPrefecences);
    Map<String, String> header = {
    'Content-Type': 'multipart/form-data',
      "Authorization": "Bearer $token",
    };
    Map<String,dynamic> map = <String, dynamic>{};
    map['user_name'] = event.fullName;
    map['contact_no'] = event.mobileNumber;
    map['email'] = event.email;
    map['date_of_birth'] = event.dob;
    map['gender'] = event.gender;
    map['firm_name'] = event.firmName;
    map['aadhar_no'] = event.aadharNumber+"12";
    map['pan_card_no'] = event.panCardNumber;
    map['gst_no'] = event.gstNumber;
    map['address'] = event.address;
    map['city'] = event.city;
    map['state'] = event.state;
    map['zip_code'] = event.pinCode;
    map['created_by_id'] = user.id;


    AddDistributorResponse response = await addDistributorStatus(event.profileImage,header,map);
    if(response.status == true ){
      emit(AddCustomerSuccess(record : response.record!));
    }else{
      emit(AddCustomerError(message: response.message));
    }
  }

  void addCustomerApi(AddCustomerClickEvent event) async {
    Map<String,dynamic> map = <String, dynamic>{};
    map['email'] = event.fullName;
    map['password'] = event.mobileNumber;
    map['password'] = event.email;
    map['password'] = event.dob;
    map['password'] = event.gender;
    map['password'] = event.fullName;
    map['password'] = event.address;
    map['password'] = event.city;
    map['password'] = event.state;
    map['password'] = event.pinCode;
    map['password'] = event.profileImage;


   /* if(response.status == true ){
      emit(AddCustomerSuccess());
    }else{
      emit(AddCustomerError(message: response.message));
    }*/
  }

  bool validateDistributor(AddDistributorClickEvent event) {
    bool fullName = false, mobileNumber = false, email = false,dob = false,gender = false,
        firmName = false,aadharNumber = false,panCardNumber = false,gstNumber = false,
        address = false,city = false, state = false, pinCode = false,profileImage = false;

    fullName = event.fullName.isEmpty && !isNameValid(event.fullName);
    mobileNumber = event.mobileNumber.isEmpty && event.mobileNumber.length != 10  ;
    email = event.email.isEmpty && !isValidEmail(event.email) ;
    dob = event.dob.isEmpty;
    gender = event.gender.isEmpty;
    firmName = event.firmName.isEmpty;
    aadharNumber = event.aadharNumber.isEmpty && event.aadharNumber.length != 12;
    panCardNumber = event.panCardNumber.isEmpty&& event.aadharNumber.length != 10;
    gstNumber = event.gstNumber.isEmpty && !isValidateGSTNumber(event.gstNumber);
    address = event.address.isEmpty && event.aadharNumber.length <=3;
    city = event.city.isEmpty;
    state = event.state.isEmpty;
    pinCode = event.pinCode.isEmpty && event.pinCode.length != 4;
    profileImage = event.profileImage.isEmpty;
    if(!fullName && !mobileNumber && !email && !dob && !gender &&  !firmName && !aadharNumber &&
        !panCardNumber &&  !gstNumber && !address && !city && !state && !pinCode && !profileImage ){
     return true;
    }else{
    return false;
     }

  }
  }

