
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/bloc/profile_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/bloc/profile_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/update_profile_api.dart';
import 'package:webnsoft_solution/modal/login/MarketingExecutiveLoginResponse.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoading()) {
    on<ProfileFetchEvent>((event, emit) {
      fetchProfile(event);
    });
    on<ProfileUpdateClickEvent>((event, emit) {
      updateMarketingProfile(event);
    });
  }

  void fetchProfile(ProfileFetchEvent event) {}

  void updateMarketingProfile(ProfileUpdateClickEvent event) {
    bool fullName = false, mobileNumber = false,email = false,gender = false,
        address = false, city = false, state = false, pinCode = false,profileImage = false;

    fullName = event.fullName.isEmpty;
    mobileNumber = event.mobileNumber.isEmpty;
    email = event.email.isEmpty;
    gender = event.gender.isEmpty;
    address = event.gender.isEmpty;
    city = event.gender.isEmpty;
    state = event.gender.isEmpty;
    pinCode = event.gender.isEmpty;
    profileImage = event.path.isEmpty;



    if(!fullName && !mobileNumber && !email &&! !gender && !address && !city && !state && !pinCode){
    updateProfileApi(event);
    }else{
      emit(ProfileError(fullName: fullName,email: email, mobileNumber: mobileNumber, address: address, city: city, state: state, pinCode: pinCode, gender: gender));
    }
  }

  void updateProfileApi(ProfileUpdateClickEvent event) async {
    String token = await getStringPref(userTokenPrefecences);
    User user = await getUser();
    Map<String, String> header = {
      'Content-Type': 'multipart/form-data',
      "Authorization": "Bearer $token",
    };
    Map<String,dynamic> map = <String, dynamic>{};
    map['user_id'] = user.id;
    map['user_name'] = event.fullName;
    map['contact_no'] = event.mobileNumber;
    map['email'] = event.email;
    map['date_of_birth'] = event.dob;
    map['gender'] = event.gender;
    map['address'] = event.address;
    map['city'] = event.city;
    map['state'] = event.state;
    map['zip_code'] = event.pinCode;


    MarketingExecutiveLoginResponse response = await editMarketExecutiveStatus(event.path,header,map);
   /* if(response.status == true ){
      emit(AddCustomerSuccess(record : response.record!));
    }else{
      emit(AddCustomerError(message: response.message));
    }*/
    emit(ProfileLoading());





  }
}
