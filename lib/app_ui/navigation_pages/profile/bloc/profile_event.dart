abstract class ProfileEvent {}

class ProfileFetchEvent extends ProfileEvent {}

class ProfileUpdateClickEvent extends ProfileEvent {
  final String fullName;
  final String mobileNumber;
  final String email;
  final String gender;
  final String dob;
  final String? firmName;
  final String? aadhaarNumber;
  final String? panNumber;
  final String? gstNumber;
  final String? houseNo;
  final String? town;
  final String address;
  final String city;
  final String state;
  final String landmark;
  final String pinCode;
  final String path;
  final bool isNewImage;

  ProfileUpdateClickEvent({
    required this.fullName,
    required this.mobileNumber,
    required this.email,
    required this.gender,
    required this.dob,
    this.firmName,
    this.aadhaarNumber,
    this.panNumber,
    this.gstNumber,
    required this.houseNo,
    required this.town,
    required this.address,
    required this.city,
    required this.state,
    required this.landmark,
    required this.pinCode,
    required this.path,
    required this.isNewImage
  });
}
