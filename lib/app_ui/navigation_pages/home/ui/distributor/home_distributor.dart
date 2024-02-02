import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/location.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/customer/customer_list/widgets/customer_list.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/ui/tabs/disributor_payment.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/ui/target_screen.dart';
import 'package:webnsoft_solution/modal/checkin_checkout/check_in_status.dart';
import 'package:webnsoft_solution/modal/checkin_checkout/checkin_checkout.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/nav_drawer/navigation_drawer.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/dialogs.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class HomeDistributorScreen extends StatefulWidget {
  final User user;

  const HomeDistributorScreen({required this.user, super.key});

  @override
  State<HomeDistributorScreen> createState() => _HomeDistributorScreenState();
}

class _HomeDistributorScreenState extends State<HomeDistributorScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _key,
          drawer: MyDrawer(user: widget.user),
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {
              if (_key.currentState != null) {
                _key.currentState!.openDrawer();
              }
            },
            icon: const Icon(
              Icons.menu,
              color: bodyWhite,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                logo,
                height: 26,
              ),
              const Space(
                width: 8,
              ),
              const BodyText(
                text: home,
                color: bodyWhite,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () => logoutDialog(context),
                icon: const Icon(
                  Icons.logout_rounded,
                  color: bodyWhite,
                ))
          ],
        ),
        body: Column(
          children:  [
             SizedBox(
              height: 50,
              child: TabBar(
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                tabs: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: const BodyText(text: 'Pending Payment'),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: const BodyText(text: "Recent Payment")),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: const BodyText(text: 'Completed Payment'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: deviceHeight -130,
              child: const TabBarView(
                children: [
                  DistributorPayments(paymentStatus: 'pending'),
                  DistributorPayments(paymentStatus: 'recent'),
                  DistributorPayments(paymentStatus: 'completed'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
