
abstract class AddCustomerEvent {}
 class AddCustomerClickEvent  extends AddCustomerEvent{
  final String name;
  final String mobileNumber;
  final String email;
  final String street;
  final String city;
  final String state;
  final String pinCode;
  AddCustomerClickEvent({required this.name,required this.mobileNumber,required this.email,required this.street,required this.city,required this.state,required this.pinCode});

 }
