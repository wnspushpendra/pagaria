import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_ui/auth/reset_password/reset_password.dart';
import 'package:webnsoft_solution/app_ui/auth/login/login.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_detail/customer_detail.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_list/widgets/customer.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/add_customer/add_customer.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_payment/customer_payment.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer_by_order/customer_by_order.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/ledger/ledger.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/ui/distributor/home_distributor.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/ui/home_marketing_executive.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/my_activity/my_activity.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/my_activity/my_shop_visits.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/notification/notification.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/create_order/create_order.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_list/order.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_detail.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/distributor_payment.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/distributor_payment_by_order.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/payment_detail/payment_detail.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/payment_list/paymens.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/checkout_sceen.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_detail/product_detail.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/excutive_payment.dart';
import 'package:webnsoft_solution/modal/argument_modal/DistributorPaymentArgument.dart';
import 'package:webnsoft_solution/modal/argument_modal/LedgetArgument.dart';
import 'package:webnsoft_solution/modal/argument_modal/ProductArgument.dart';
import 'package:webnsoft_solution/modal/customer_detail.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/order/user_role_order_list_modal.dart';
import 'package:webnsoft_solution/modal/payment/payment_list_modal.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;

    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case homeRoute:
        return MaterialPageRoute(
            builder: (_) => HomeScreen(
                  user: arguments as User,
                ));
      case notificationRoute:
        return MaterialPageRoute(builder: (_) => const NotificationList());
      case profileRoute:
        return MaterialPageRoute(
            builder: (_) => ProfileScreen(user: arguments as User));
      case myActivityRoute:
        return MaterialPageRoute(
            builder: (_) => const UserActivity());
       case myVisitRoute:
        return MaterialPageRoute(
            builder: (_) => const MyShopVisitActivity());
      case resetPasswordRoute:
        return MaterialPageRoute(
            builder: (_) => ResetPassword(
                  user: arguments as User,
                ));
      case productRoute:
        return MaterialPageRoute(
            builder: (_) => ProductScreen(
              distributor: arguments as User?,
                ));
      case checkOutRoute:
        return MaterialPageRoute(
            builder: (_) => CheckOutScreen(
              distributor: arguments as User,
                ));
      case productDetailRoute:
        return MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
                productArgument: arguments as ProductArgument));
      case addCustomerRoute:
        return MaterialPageRoute(builder: (_) => const AddCustomerScreen());
      case customerDetailRoute:
        return MaterialPageRoute(builder: (_) => CustomerDetailScreen(customerDetailModal: arguments as CustomerDetailModal, /*customer: arguments as Customer,from: arguments as int,*/));
      case customerListRoute:return MaterialPageRoute(builder: (_) => const CustomerListScreen());
      case paymentListRoute:
        return MaterialPageRoute(builder: (_) => const PaymentListScreen());
        case customerForOrderRoute:
        return MaterialPageRoute(builder: (_) => const SpecificCustomerOrder());
    case paymentDetailRoute:
      return MaterialPageRoute(builder: (_) =>  PaymentDetailScreen(paymentDetail: arguments as PaymentDetailData));
  /*    case addCustomerRoute:
        return MaterialPageRoute(builder: (_) => const AddCustomerScreen());*/
      case createOrderRoute:
        return MaterialPageRoute(builder: (_) => const CreateOrderScreen());
      case orderRoute:
        return MaterialPageRoute(
            builder: (_) => OrderScreen(
                  showAppbar: arguments as bool,
                ));
      case orderDetailRoute:
        return MaterialPageRoute(
            builder: (_) => OrderDetailScreen(order: arguments as Order,));
      case paymentRoute:
        return MaterialPageRoute(
            builder: (_) => const ExecutivePaymentScreen());
      case customerPaymentRoute:
        return MaterialPageRoute(
            builder: (_) => CustomerPaymentScreen(customer: arguments as User,));
      case ledgerRoute:
        return MaterialPageRoute(
            builder: (_) =>
                LedgerScreen(argument: arguments as LedgerArgument));

      // distributor routes
      case homeDistributorRoute:
        return MaterialPageRoute(
            builder: (_) => HomeDistributorScreen(user: arguments as User,));
      case distributorPaymentRoute:
        return MaterialPageRoute(
            builder: (_) => DistributorPaymentScreen(customerId: arguments as String,));
      case distributorOrderPaymentRoute:
        return MaterialPageRoute(
            builder: (_) => DistributorOrderPaymentScreen(argument: arguments as DistributorPaymentArgument,));


      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
