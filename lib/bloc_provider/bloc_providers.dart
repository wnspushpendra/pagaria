
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:webnsoft_solution/app_ui/auth/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:webnsoft_solution/app_ui/auth/login/bloc/login_bloc.dart';
import 'package:webnsoft_solution/app_ui/auth/reset_password/bloc/reset_password_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/add_customer/bloc/add_customer_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/logout_bloc/logout_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/target_bloc/target_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/ledger/bloc/ledger_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/my_activity/bloc/my_activity_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/notification/bloc/notification_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/bloc/payment_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/category_bloc/category_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_detail/product_details_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/bloc/profile_bloc.dart';
import 'package:webnsoft_solution/internet_cubit/internet_cubit.dart';

get getProvider => [
  BlocProvider(create: (context) => InternetCubit()),
  BlocProvider(create: (context) => LoginBloc()),
  BlocProvider(create: (context) => LogoutBloc()),
  BlocProvider(create: (context) => HomeBloc()),
  BlocProvider(create: (context) => NotificationBloc()),
  BlocProvider(create: (context) => TargetBloc()),
  BlocProvider(create: (context) => CategoryBloc()),
  BlocProvider(create: (context) => ProductBloc()),
  BlocProvider(create: (context) => ProductDetailsBloc()),
  BlocProvider(create: (context) => OrderBloc()),
  BlocProvider(create: (context) => PaymentBloc()),
  BlocProvider(create: (context) => AddCustomerBloc()),
  BlocProvider(create: (context) => ProfileBloc()),
  BlocProvider(create: (context) => ResetPasswordBloc()),
  BlocProvider(create: (context) => ForgotPasswordBloc()),
  BlocProvider(create: (context) => PaymentBloc()),
  BlocProvider(create: (context) => CheckOutBloc()),
  BlocProvider(create: (context) => MyActivityBloc()),
  BlocProvider(create: (context) => LedgerBloc()),

];