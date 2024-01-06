import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_ui/auth/change_password/reset_password.dart';
import 'package:webnsoft_solution/app_ui/auth/login/login.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_detail/customer_detail.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_list/widgets/customer.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/add_customer/add_customer.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_payment/customer_payment.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/ui/home.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/create_order.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_list/order.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_detail.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_detail/product_detail.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/payment.dart';
import 'package:webnsoft_solution/modal/login/MarketingExecutiveLoginResponse.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';

class CustomRouter{

  static Route<dynamic> generateRoute(RouteSettings settings){
  var   arguments = settings.arguments;

    switch(settings.name){
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) =>  HomeScreen(user: arguments as User,));
      case profileRoute:
        return MaterialPageRoute(builder: (_) =>  ProfileScreen(user : arguments as User));
      case resetPasswordRoute:
        return MaterialPageRoute(builder: (_) =>  ResetPassword());
      case productRoute:
        return MaterialPageRoute(builder: (_) =>   const ProductScreen());
      case productDetailRoute:
        return MaterialPageRoute(builder: (_) =>  ProductDetailScreen(from : arguments as String));
      case addCustomerRoute:
        return MaterialPageRoute(builder: (_) => const AddCustomerScreen());
      case customerDetailRoute:
        return MaterialPageRoute(builder: (_) =>  CustomerDetailScreen(index: arguments as int,));
      case customerRoute:
        return MaterialPageRoute(builder: (_) => const CustomerScreen());
      case addCustomerRoute:
        return MaterialPageRoute(builder: (_) => const AddCustomerScreen());
      case createOrderRoute:
        return MaterialPageRoute(builder: (_) => const CreateOrderScreen());
      case orderRoute:
        return MaterialPageRoute(builder: (_) => const OrderScreen());
      case orderDetailRoute:
        return MaterialPageRoute(builder: (_) => const OrderDetailScreen());
      case paymentRoute:
        return MaterialPageRoute(builder: (_) => const PaymentScreen());
      case customerPaymentRoute:
        return MaterialPageRoute(builder: (_) => const CustomerPaymentScreen());

      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}