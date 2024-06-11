import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/bloc/profile_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/bloc/profile_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile_detail_api.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/update_profile_api.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/profile_detail.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoading()) {
    /***************** call event for fetch user detail ****************/

    on<ProfileFetchEvent>((event, emit) {
      fetchProfile(event);
    });

    /***************** call event for update user ****************/
    on<ProfileUpdateClickEvent>((event, emit) {
      updateProfile(event);
    });
  }

  void fetchProfile(ProfileFetchEvent event) async {
    /***************** getting token from preference      ****************/
    String token = await getStringPref(userTokenPrefecences);
    /***************** getting user from preference  method  ****************/
    User user = await getUser();

    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };
    Map<String, dynamic> map = <String, dynamic>{};
    map['user_id'] = user.id.toString();

    ProfileDetailResponse response =
        await fetchProfileDetailsStatus(header, map);
    if (response.status == true && response.userProfile != null) {
      emit(ProfileFetchSuccess(user: response.userProfile!));
    } else {
      emit(ProfileError(errorMessage: response.message.toString()));
    }
  }

  /// ************* update user api   **************
  void updateProfile(ProfileUpdateClickEvent event) async {
    /// ************* validate user   **************
    bool validate = await updateMarketingExecutiveProfileValidate(event);
    if (validate) {
      /// ************* update user api submit   **************
      updateProfileDetails(event);
    }
  }

  /// ************* update user api   **************
  void updateProfileDetails(ProfileUpdateClickEvent event) async {
    Map<String, String> header = {
      'Content-Type': 'multipart/form-data',
      "Authorization": "Bearer ${await getStringPref(userTokenPrefecences)}",
    };
    /***************** getting user from preference  method  ****************/
    User user = await getUser();

    Map<String, dynamic> map = <String, dynamic>{};
    map['user_id'] = user.id;
    map['role_id'] = user.roleId;
    map['user_name'] = event.fullName;
    map['contact_no'] = event.mobileNumber;
    map['email'] = event.email;
    map['date_of_birth'] = event.dob;
    map['gender'] = event.gender;
    map['house_number'] = event.houseNo== 'NA' ? '': event.houseNo;
    map['town'] = event.town== 'NA' ? '': event.town;
    map['address'] = event.address== 'NA' ? '': event.address;
    map['city'] = event.city== 'NA' ? '': event.city;
    map['state'] = event.state == 'NA' ? '': event.state;
    map['zip_code'] = event.pinCode== 'NA' ? '': event.pinCode;
    map['landmark'] = event.landmark== 'NA' ? '': event.landmark;
    if (user.roleId == '5') {
      map['firm_name'] = event.firmName;
      map['aadhar_no'] = event.aadhaarNumber == 'NA' ? '' : event.aadhaarNumber!.replaceAll(' ', '') ;
      map['pan_card_no'] = event.panNumber== 'NA' ? '': event.panNumber;
      map['gst_no'] = event.gstNumber== 'NA' ? '': event.gstNumber;
    }

    emit(ProfileLoading());

    try {
      // request for api
      UserResponse response = await editMarketExecutiveStatus(event.isNewImage, event.path, header, map, user.roleId.toString());
      // checking response status and emitting state.
      if (response.status == true) {
        saveUserPref(response.profileData!.user!, userProfileDataPrefecences);
        emit(ProfileSuccess(message: response.message.toString()));
      } else {
        emit(ProfileError(errorMessage: response.message.toString()));
      }
    }catch(e){
      emit(ProfileError(errorMessage: e.toString()));
    }
  }

  /// ************* update user validation   **************
  Future<bool> updateMarketingExecutiveProfileValidate(
      ProfileUpdateClickEvent event) async {
    bool validate = false;

    bool fullName = false,
        mobileNumber = false,
        email = false,
        gender = false,
        address = false,
        city = false,
        state = false,
        pinCode = false,
        profileImage = false,aadhaarNumber = false,panCardNumber = false,gstNumber = false,firmName = false;
    fullName = event.fullName.isEmpty;
    mobileNumber = event.mobileNumber.isEmpty;
    gender = event.gender.isEmpty;
    firmName = event.firmName != null && event.firmName!.isEmpty;
    // address = event.address.isEmpty;
   // city = event.city.isEmpty;
   // state = event.state.isEmpty;
    pinCode = event.gender.isEmpty;
    profileImage = event.path.isEmpty;
    aadhaarNumber = event.aadhaarNumber != null && event.aadhaarNumber!.isEmpty && event.aadhaarNumber!.length != 12;
    panCardNumber = event.panNumber != null && event.panNumber!.isEmpty && event.panNumber!.length != 10;
    gstNumber = event.gstNumber != null && event.gstNumber!.isEmpty && event.gstNumber!.length != 15;

    User user = await getUser();
    if (user.roleId == '4') {
      if (!fullName && !mobileNumber && !email && !gender && !address && !city && !state && !pinCode && !profileImage) {
        if(event.mobileNumber.isNotEmpty &&  event.mobileNumber.length != 10){
          emit(ProfileError( aadhaarNumber: true));
          return false;
        }
        if(event.panNumber != null &&  event.panNumber!.length != 10){
          emit(ProfileError( panNumber: true));
          return false;
        }
        if(event.gstNumber != null &&  event.gstNumber!.length != 15){
          emit(ProfileError( gst: true));
          return false;
        }
        if(event.pinCode.isNotEmpty && event.pinCode.length != 6){
          emit(ProfileError( pinCode: true));
          return false;
        }

        return true;
      } else {
        emit(ProfileError(fullName: fullName, email: email, mobileNumber: mobileNumber, address: address, city: city, state: state, pinCode: pinCode, gender: gender));
        return false;
      }
    } else {
      if (!fullName && !mobileNumber && !email && !gender && !address && !city && !state && !pinCode && !profileImage /*&& !firmName && !aadhaarNumber && !panCardNumber && !gstNumber*/) {
        return true;
      } else {
        emit(ProfileError(
            fullName: fullName,
            email: email,
            mobileNumber: mobileNumber,
            address: address,
            city: city,
            state: state,
            pinCode: pinCode,
            gender: gender));
        return false;
      }
    }
  }
}
