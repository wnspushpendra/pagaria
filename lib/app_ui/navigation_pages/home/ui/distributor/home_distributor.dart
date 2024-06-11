import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';

import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/home_bloc/home_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/ui/distributor/featured_product.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/ui/tabs/disributor_payment.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/notification/notification_count.dart';
import 'package:webnsoft_solution/modal/argument_modal/DistributorHomeArgument.dart';
import 'package:webnsoft_solution/modal/distributor/distributo_payment_modal.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/modal/product_list.dart';
import 'package:webnsoft_solution/nav_drawer/navigation_drawer.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class HomeDistributorScreen extends StatefulWidget {
  final User user;

  const HomeDistributorScreen({required this.user, super.key});

  @override
  State<HomeDistributorScreen> createState() => _HomeDistributorScreenState();
}

class _HomeDistributorScreenState extends State<HomeDistributorScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  List<DistributorPayment> recentPaymentList = [];
  List<DistributorPayment> pendingPaymentList = [];
  List<DistributorPayment> completedPaymentList = [];
  String? errorMessage;
  bool distributorLoading = true;
  String? count;
  ScrollController _scrollController = ScrollController();
  bool _isAtBottom = false;

  @override
  void initState() {
    context.read<HomeBloc>().add(FirebaseTokenEvent());
    context.read<HomeBloc>().add(HomeFetchDistributorPaymentEvent());
    super.initState();
    _scrollController.addListener(_scrollListener);

  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          _isAtBottom = true;
        });
      } else {
        setState(() {
          _isAtBottom = false;
        });
      }
    } else {
      setState(() {
        _isAtBottom = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 4,
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
          actions:  const [
    /*        SizedBox(
              width: 10,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                  onPressed: () async => ChangeRoutes.openProductScreen(context, await getUser(), await ChangeRoutes.getUserId()),
                  icon: const Icon(Icons.add,color: bodyWhite,)),
            ),*/
            NotificationCount()
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => ChangeRoutes.openProductScreen(context, await getUser(), await ChangeRoutes.getUser()),
          child: const Icon(Icons.add),

        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeSuccess) {
              distributorLoading = false;
              recentPaymentList = state.recentOrderList!;
              pendingPaymentList = state.pendingOrderList!;
              completedPaymentList = state.completedOrderList!;
              setState(() {});
            }
            if (state is HomeError) {
              ChangeRoutes.unAuthorizedError(context, state.error);
              distributorLoading = false;
              errorMessage = state.error;
              setState(() {});
            }
          },
          builder: (context, state) {
            return distributorLoading
                ? const Center(
                    child: CustomProgressBar(
                      color: primaryColor,
                    ),
                  )
                : errorMessage != null
                    ? Center(
                        child: BodyText(
                          text: errorMessage!,
                          color: primaryColor,
                        ),
                      )
                    : Stack(
                      children: [
                        ListView(
                            children: [
                              SizedBox(
                                height: 50,
                                child: TabBar(
                                  tabAlignment: TabAlignment.start,
                                  isScrollable: true,
                                  tabs: [
                                    Container(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                      child:
                                          const BodyText(text: 'Featured Products'),
                                    ),
                                    Container(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                      child:
                                          const BodyText(text: 'Pending Payment'),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child:
                                            const BodyText(text: "Recent Payment")),
                                    Container(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 8.0),
                                      child:
                                          const BodyText(text: 'Completed Payment'),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: deviceHeight - 130,
                                margin: const EdgeInsets.only(bottom: 60),
                                child: TabBarView(
                                  children: [
                                    const FeaturedProductScreen(),
                                    DistributorPayments(
                                        argument: DistributorHomeArgument(
                                            status: 'pending',
                                            orderList: pendingPaymentList)),
                                    DistributorPayments(
                                        argument: DistributorHomeArgument(
                                            status: 'recent',
                                            orderList: recentPaymentList)),
                                    DistributorPayments(
                                        argument: DistributorHomeArgument(
                                            status: 'completed',
                                            orderList: completedPaymentList)),
                                  ],
                                ),
                              ),
                            ],
                          ),

                       /* Positioned(
                          bottom: 0,
                          left: 10.h,
                          child: CustomButton(buttonText: order,
                              buttonWidth: 140.h,
                              radius: 30.h,
                              onClick: (){}),
                        )*/
                      ],
                    );
          },
        ),
      ),
    );
  }
}
