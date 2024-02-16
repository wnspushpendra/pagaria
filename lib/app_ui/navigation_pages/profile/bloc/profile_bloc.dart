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
/*    bool fullName = false, mobileNumber = false, email = false, gender = false, address = false, city = false, state = false, pinCode = false, profileImage = false;

    fullName = event.fullName.isEmpty;
    mobileNumber = event.mobileNumber.isEmpty;
    email = event.email.isEmpty;
    gender = event.gender.isEmpty;
    address = event.gender.isEmpty;
    city = event.gender.isEmpty;
    state = event.gender.isEmpty;
    pinCode = event.gender.isEmpty;
    profileImage = event.path.isEmpty;

    if (!fullName && !mobileNumber && !email && !gender && !address && !city && !state && !pinCode) {
      updateProfileApi(event);
    } else {
      emit(ProfileError(fullName: fullName, email: email, mobileNumber: mobileNumber, address: address, city: city, state: state, pinCode: pinCode, gender: gender));
    }*/
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
    map['address'] = event.address;
    map['city'] = event.city;
    map['state'] = event.state;
    map['zip_code'] = event.pinCode;
    if (user.roleId == '5') {
      map['firm_name'] = event.firmName;
      map['aadhar_no'] = event.aadhaarNumber;
      map['pan_card_no'] = event.panNumber;
      map['gst_no'] = event.gstNumber;
    }

    print(map);

    emit(ProfileLoading());
    // request for api
    UserResponse response = await editMarketExecutiveStatus(event.isNewImage, event.path, header, map,user.roleId.toString());
    // checking response status and emitting state.
    if (response.status == true) {
      saveUserPref(response.profileData!.user!, userProfileDataPrefecences);
      User user = await getUserPref(userProfileDataPrefecences);
      print(user);
      emit(ProfileSuccess(message: response.message.toString()));
    } else {
      emit(ProfileError(errorMessage: response.message.toString()));
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
    email = event.email.isEmpty;
    gender = event.gender.isEmpty;
    address = event.gender.isEmpty;
    city = event.gender.isEmpty;
    state = event.gender.isEmpty;
    pinCode = event.gender.isEmpty;
    profileImage = event.path.isEmpty;
    firmName = event.firmName != null && event.firmName!.isEmpty;
    aadhaarNumber = event.aadhaarNumber != null && event.aadhaarNumber!.isEmpty && event.aadhaarNumber!.length != 12;
    panCardNumber = event.panNumber != null && event.panNumber!.isEmpty && event.panNumber!.length != 10;
    gstNumber = event.gstNumber != null && event.gstNumber!.isEmpty && event.gstNumber!.length != 15;

    User user = await getUser();
    if (user.roleId == '4') {
      if (!fullName && !mobileNumber && !email && !gender && !address && !city && !state && !pinCode && !profileImage) {
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
