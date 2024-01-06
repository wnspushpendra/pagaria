
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileSuccess extends ProfileState {}
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

