
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile_state.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoading()) {
    on<ProfileFetchEvent>((event, emit) {
      fetchProfile(event);
    });
    on<ProfileUpdateClickEvent>((event, emit) {
      updateProfile(event);
    });
  }

  void fetchProfile(ProfileFetchEvent event) {}

  void updateProfile(ProfileUpdateClickEvent event) {
    bool firstName = false,lastName = false, mobileNumber = false,email = false, aadharNumber = false,panNumber = false,street = false,city = false, state = false, pinCode = false,gender = false;

    firstName = event.firstName.isEmpty;
    lastName = event.lastName.isEmpty;
    mobileNumber = event.mobileNumber.isEmpty;
    email = event.email.isEmpty;
    aadharNumber = event.aadharNumber.isEmpty;
    panNumber = event.panNumber.isEmpty;
    street = event.aadharNumber.isEmpty;
    city = event.city.isEmpty;
    state = event.state.isEmpty;
    pinCode = event.pinCode.isEmpty;
    gender = event.gender.isEmpty;

    if(!firstName && !lastName && !mobileNumber && !email &&!aadharNumber && !panNumber && !street && !city && !state && !pinCode && !gender){
      print(' validate successfully');
    }else{
      emit(ProfileError(firstName: firstName, lastName: lastName, mobileNumber: mobileNumber, email: email, aadharNumber: aadharNumber,panNumber : panNumber, street: street, city: city, state: state, pinCode: pinCode, gender: gender));
    }
  }
}
