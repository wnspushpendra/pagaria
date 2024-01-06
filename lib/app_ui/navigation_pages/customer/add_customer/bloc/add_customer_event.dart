
abstract class AddCustomerEvent {}

/// ******** event for adding distributor *******************

 class AddDistributorClickEvent  extends AddCustomerEvent{
  final String fullName;
  final String mobileNumber;
  final String email;
  final String dob;
  final String gender;
  final String firmName;
  final String aadharNumber;
  final String panCardNumber;
  final String gstNumber;
  final String address;
  final String city;
  final String state;
  final String pinCode;
  final String profileImage;
  AddDistributorClickEvent({required this.fullName,required this.mobileNumber,required this.email,
   required this.dob,required this.gender,required this.firmName,required this.aadharNumber,required this.panCardNumber,required this.gstNumber,
   required this.address,required this.city,required this.state,required this.pinCode,required this.profileImage});

 }

/// ******** event for adding customer *******************

class AddCustomerClickEvent  extends AddCustomerEvent{
  final String fullName;
  final String mobileNumber;
  final String email;
  final String dob;
  final String gender;
  final String address;
  final String city;
  final String state;
  final String pinCode;
  final String profileImage;

  AddCustomerClickEvent({required this.fullName,required this.mobileNumber,required this.email,
   required this.dob,required this.gender, required this.address,required this.city,required this.state,required this.pinCode,required this.profileImage});

 }
