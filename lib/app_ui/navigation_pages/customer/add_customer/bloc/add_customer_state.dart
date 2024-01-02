
abstract class AddCustomerState {}

class AddCustomerInitial extends AddCustomerState {}
class AddCustomerLoading extends AddCustomerState {}
class AddCustomerSuccess extends AddCustomerState {}
class AddCustomerError extends AddCustomerState {
  final bool? name;
  final bool? mobileNumber;
  final bool? email;
  final bool? street;
  final bool? city;
  final bool? state;
  final bool? pinCode;
  final String? errorMessage;

  AddCustomerError({ this.name, this.mobileNumber, this.email, this.street, this.city, this.state, this.pinCode, this.errorMessage});
}
