
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/payment_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<PaymentClickEvent>((event, emit) {
    });
  }
}
