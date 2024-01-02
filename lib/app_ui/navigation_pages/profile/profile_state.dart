
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileSuccess extends ProfileState {}
class ProfileError extends ProfileState {
  final bool? firstName;
  final bool? lastName;
  final bool? mobileNumber;
  final bool? email;
  final bool? aadharNumber;
  final bool? panNumber;
  final bool? street;
  final bool? city;
  final bool? state;
  final bool? pinCode;
  final bool? gender;
  final String? errorMessage;

  ProfileError({
     this.firstName,
     this.lastName,
     this.mobileNumber,
     this.email,
     this.aadharNumber,
     this.panNumber,
     this.street,
     this.city,
     this.state,
     this.pinCode,
     this.gender,
     this.errorMessage
  });
}

