abstract class ProfileEvent {}

class ProfileFetchEvent extends ProfileEvent {}

class ProfileUpdateClickEvent extends ProfileEvent {
  final String fullName;
  final String mobileNumber;
  final String email;
  final String gender;
  final String dob;
  final String? aadharNumber;
  final String? panNumber;
  final String? gstNumber;
  final String address;
  final String city;
  final String state;
  final String pinCode;
  final String path;

  ProfileUpdateClickEvent({
    required this.fullName,
    required this.mobileNumber,
    required this.email,
    required this.gender,
    required this.dob,
    this.aadharNumber,
    this.panNumber,
    this.gstNumber,
    required this.address,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.path,
  });
}
