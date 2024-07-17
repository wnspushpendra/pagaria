
import 'package:webnsoft_solution/modal/AddDistributor.dart';

abstract class AddCustomerState {}

class AddCustomerInitial extends AddCustomerState {}
class AddCustomerLoading extends AddCustomerState {}
class AddCustomerSuccess extends AddCustomerState {
  DistributorProfileRecord record;
  AddCustomerSuccess({required this.record});
}
class AddCustomerError extends AddCustomerState {
  final bool? name;
  final bool? mobileNumber;
  final bool? email;
  final bool? dob;
  final bool? gender;
  final bool? firmName;
  final bool? aadharNumber;
  final bool? panCardNumber;
  final bool? gstNumber;
  final bool? address;
  final bool? city;
  final bool? state;
  final bool? pinCode;
  final bool? profileImage;
  final String? message;

  AddCustomerError({ this.name, this.mobileNumber, this.email,this.dob,this.gender,
    this.firmName,this.aadharNumber,this.panCardNumber,this.gstNumber,this.address
    , this.city, this.state, this.pinCode, this.message,this.profileImage});
}
