import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_apis.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_state.dart';
import 'package:webnsoft_solution/modal/checkin_checkout/check_in_status.dart';
import 'package:webnsoft_solution/modal/checkin_checkout/checkin_checkout.dart';
import 'package:webnsoft_solution/modal/distributor/distributo_payment_modal.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<HomeTargetFetchEvent>((event, emit) {
      fetchTargetApi(event);
    });
    on<HomeCustomerFetchEvent>((event, emit) => fetchCustomerApi(event));
    on<HomeCheckInStatusEvent>((event, emit) => checkInOutStatusApi(event));
    on<HomeCheckInOutUpdateEvent>((event, emit) {
      checkInOutApi(event);
    });
    on<HomeFetchDistributorPaymentEvent>((event, emit) {
      fetchDistributorPayments(event);
    });
  }

  void fetchTargetApi(HomeTargetFetchEvent event) {}

  void checkInOutStatusApi(HomeCheckInStatusEvent event) async {
    /***************** getting token from preference      ****************/
    String token = await getStringPref(userTokenPrefecences);
    /***************** getting user from preference  method  ****************/
    User user = await getUser();

    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };

    Map<String, dynamic> body = <String, dynamic>{};
    body['user_id'] = user.id.toString();

    try {
      CheckInDetails response = await checkInDetailsApi(header, body);
      if (response.status == true && response.checkInData != null) {
        emit(HomeSuccess(checkInData: response.checkInData!));
      } else {
        emit(HomeCheckInOurError(error: response.message.toString()));
      }
    } catch (e) {
      emit(HomeCheckInOurError(error: unAuthorization));
    }
  }

  void checkInOutApi(HomeCheckInOutUpdateEvent event) async {
    /***************** getting token from preference      ****************/
    String token = await getStringPref(userTokenPrefecences);
    /***************** getting user from preference  method  ****************/
    User user = await getUser();

    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };

    String address =
        '${event.placeMark?.street}, ${event.placeMark?.locality}, ${event.placeMark?.administrativeArea}, ${event.placeMark?.country}';
    String zipCode = '${event.placeMark?.postalCode}';

    String status =
        event.checkInOutStatus == 'check_in' ? 'check_out' : 'check_in';

    Map<String, dynamic> body = <String, dynamic>{};
    body['marketing_executive_id'] = user.id.toString();
    body['status_type'] = status;
    body['latitude'] = event.locationData.latitude.toString();
    body['longitude'] = event.locationData.longitude.toString();
    body['address'] = address;
    body['zip_code'] = zipCode;

    emit(HomeCheckInOutLoading());

    try {
      CheckInCheckOutResponse response =
          await checkInOutUpdateApi(header, body);
      if (response.status == true && response.checkInOutRecord != null) {
        emit(HomeSuccess(checkInOutRecord: response.checkInOutRecord!));
      } else {
        emit(HomeError(error: response.message.toString()));
      }
    } catch (e) {
      emit(HomeError(error: unAuthorization));
    }
  }

  void fetchCustomerApi(HomeCustomerFetchEvent event) async {
    /***************** getting token from preference      ****************/
    String token = await getStringPref(userTokenPrefecences);
    /***************** getting user from preference  method  ****************/
    User user = await getUser();

    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };

    Map<String, dynamic> body = <String, dynamic>{};
    body['user_id'] = user.id.toString();
    body['data_type'] = 'type_distributor';

    try {
      DistributorListResponse response = await distributorListApi(header, body);
      if (response.status == true && response.customerList != null) {
        emit(HomeSuccess(distributorList: response.customerList!));
      } else {
        emit(HomeError(error: response.message.toString()));
      }
    } catch (e) {
      emit(HomeError(error: unAuthorization));
    }
  }

  void fetchDistributorPayments(HomeFetchDistributorPaymentEvent event) async {
    /***************** getting token from preference      ****************/
    String token = await getStringPref(userTokenPrefecences);
    /***************** getting user from preference  method  ****************/
    User user = await getUser();

    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };

    Map<String, dynamic> body = <String, dynamic>{};
    body['user_id'] = user.id.toString();
    body['user_type'] = 'type_marketing_ex';

    try {
      DistributorPaymentModal response =
          await distributorPayments(header, body);
      if (response.status == true) {
        emit(HomeSuccess(
            recentOrderList: response.recentPayment!,
            pendingOrderList: response.duePayment,
            completedOrderList: response.completedPayment));
      } else {
        emit(HomeError(error: response.message.toString()));
      }
    } catch (e) {
      emit(HomeError(error: unAuthorization));
    }
  }
}
