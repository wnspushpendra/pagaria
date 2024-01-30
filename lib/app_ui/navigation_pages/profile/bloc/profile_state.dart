
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/profile_detail.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ProfileFetchLoading extends ProfileState {}

class ProfileFetchSuccess extends ProfileState {
  final Profile user;
  ProfileFetchSuccess({required this.user});
}
class ProfileLoading extends ProfileState {}
class ProfileSuccess extends ProfileState {
  final String message;
  ProfileSuccess({required this.message});
}
class ProfileError extends ProfileState {
  final bool? fullName;
  final bool? mobileNumber;
  final bool? email;
  final bool? aadharNumber;
  final bool? panNumber;
  final bool? address;
  final bool? city;
  final bool? state;
  final bool? pinCode;
  final bool? gender;
  final String? errorMessage;

  ProfileError({
     this.fullName,
     this.mobileNumber,
     this.email,
     this.aadharNumber,
     this.panNumber,
     this.address,
     this.city,
     this.state,
     this.pinCode,
     this.gender,
     this.errorMessage
  });
}

