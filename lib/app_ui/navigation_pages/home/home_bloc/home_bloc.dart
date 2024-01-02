
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<HomeTargetFetchEvent>((event, emit) {
      fetchTargetApi(event);
    });
    on<HomeCustomerFetchEvent>((event, emit) {
      fetchCustomerApi(event);
    });
  }

  void fetchTargetApi(HomeTargetFetchEvent event) {}

  void fetchCustomerApi(HomeCustomerFetchEvent event) {}
}
