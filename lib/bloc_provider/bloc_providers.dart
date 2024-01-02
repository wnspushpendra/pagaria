
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/app_ui/login/login_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/add_customer/bloc/add_customer_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/payment_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/category_bloc/category_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile_bloc.dart';

get getProvider => [
  BlocProvider(create: (context) => LoginBloc()),
  BlocProvider(create: (context) => CategoryBloc()),
  BlocProvider(create: (context) => ProductBloc()),
  BlocProvider(create: (context) => AddCustomerBloc()),
  BlocProvider(create: (context) => ProfileBloc()),
  BlocProvider(create: (context) => PaymentBloc()),

];