import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_ui/auth/reset_password/reset_password.dart';
import 'package:webnsoft_solution/app_ui/auth/login/login.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_detail/customer_detail.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_list/widgets/customer.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/add_customer/add_customer.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_payment/customer_payment.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/ledger/ledger.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/ledger/ledger_detail.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/ui/distributor/home_distributor.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/ui/home_marketing_executive.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/notification/notification.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/create_order.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_list/order.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_detail.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/checkout/checkout_sceen.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_detail/product_detail.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/payment.dart';
import 'package:webnsoft_solution/modal/argument_modal/LedgetArgument.dart';
import 'package:webnsoft_solution/modal/argument_modal/ProductArgument.dart';
import 'package:webnsoft_solution/modal/customer_detail.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/modal/argument_modal/HomeArgument.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/order/order_list_modal.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';

class CustomRouter{

  static Route<dynamic> generateRoute(RouteSettings settings){
  var   arguments = settings.arguments;

    switch(settings.name){
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) =>  HomeScreen(user: arguments as User,));
      case notificationRoute:
        return MaterialPageRoute(builder: (_) =>  const NotificationList());
      case profileRoute:
        return MaterialPageRoute(builder: (_) =>  ProfileScreen(user : arguments as User));
      case resetPasswordRoute:
        return MaterialPageRoute(builder: (_) =>  ResetPassword(user: arguments as User,));
      case productRoute:
        return MaterialPageRoute(builder: (_) =>    ProductScreen(distributorId: arguments as String?,));
      case checkOutRoute:
        return MaterialPageRoute(builder: (_) =>     CheckOutScreen(distributorId: arguments as String,));
      case productDetailRoute:
        return MaterialPageRoute(builder: (_) =>  ProductDetailScreen(productArgument:arguments as ProductArgument));
      case addCustomerRoute:
        return MaterialPageRoute(builder: (_) => const AddCustomerScreen());
      case customerDetailRoute:
        return MaterialPageRoute(builder: (_) =>  CustomerDetailScreen(customerDetailModal: arguments as CustomerDetailModal,   /*customer: arguments as Customer,from: arguments as int,*/));
      case customerRoute:
        return MaterialPageRoute(builder: (_) => const CustomerScreen());
      case addCustomerRoute:
        return MaterialPageRoute(builder: (_) => const AddCustomerScreen());
      case createOrderRoute:
        return MaterialPageRoute(builder: (_) => const CreateOrderScreen());
      case orderRoute:
        return MaterialPageRoute(builder: (_) =>  OrderScreen(showAppbar: arguments as bool,));
      case orderDetailRoute:
        return MaterialPageRoute(builder: (_) =>  OrderDetailScreen(order: arguments as OrderList,));
      case paymentRoute:
        return MaterialPageRoute(builder: (_) =>  PaymentScreen(order: arguments as  OrderList?,));
      case customerPaymentRoute:
        return MaterialPageRoute(builder: (_) =>  CustomerPaymentScreen(customer: arguments as Customer,));
      case ledgerRoute:
        return MaterialPageRoute(builder: (_) =>  LedgerScreen(argument: arguments as LedgerArgument));

      case ledgerDetailRoute:
        return MaterialPageRoute(builder: (_) =>  LedgerDetailScreen(order: arguments as OrderList,));


        // distributor routes

      case homeDistributorRoute:
        return MaterialPageRoute(builder: (_) =>  HomeDistributorScreen(user: arguments as User,));


      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}