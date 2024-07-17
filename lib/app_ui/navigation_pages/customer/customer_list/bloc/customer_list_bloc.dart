
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_list/bloc/customer_list_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_list/bloc/customer_list_state.dart';

class CustomerListBloc extends Bloc<CustomerListEvent, CustomerListState> {
  CustomerListBloc() : super(CustomerListLoading()) {
    on<CustomerListFetch>((event, emit) {
      customerListFetchApi(event);
    });
  }
  void customerListFetchApi(CustomerListFetch event) {}
}
