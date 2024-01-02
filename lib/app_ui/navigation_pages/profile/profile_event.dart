abstract class ProfileEvent {}

class ProfileFetchEvent extends ProfileEvent {}

class ProfileUpdateClickEvent extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String email;
  final String aadharNumber;
  final String panNumber;
  final String street;
  final String city;
  final String state;
  final String pinCode;
  final String gender;

  ProfileUpdateClickEvent(
      {required this.firstName,
      required this.lastName,
      required this.mobileNumber,
      required this.email,
      required this.aadharNumber,
      required this.panNumber,
      required this.street,
      required this.city,
      required this.state,
      required this.pinCode,
      required this.gender});
}
