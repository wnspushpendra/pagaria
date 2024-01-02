
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/add_customer/bloc/add_customer_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/add_customer/bloc/add_customer_state.dart';

class AddCustomerBloc extends Bloc<AddCustomerEvent, AddCustomerState> {
  AddCustomerBloc() : super(AddCustomerInitial()) {
    on<AddCustomerClickEvent>((event, emit) {
      bool name = false, mobileNumber = false, email = false,street = false,city = false, state = false, pinCode = false;

      name = event.name.isEmpty;
      mobileNumber = event.mobileNumber.isEmpty;
      email = event.email.isEmpty;
      street = event.street.isEmpty;
      city = event.city.isEmpty;
      state = event.state.isEmpty;
      pinCode = event.pinCode.isEmpty;

      if(!name && !mobileNumber && !email && !street && !city && !state && !pinCode ){

       print('success');
      }else{
        emit(AddCustomerError(name: name, mobileNumber: mobileNumber, email: email, street: street, city: city, state: state, pinCode: pinCode,));
      }


    });
  }
}
