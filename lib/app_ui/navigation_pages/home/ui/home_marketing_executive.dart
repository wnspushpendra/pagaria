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
import 'package:webnsoft_solution/app_ui/navigation_pages/home/ui/target_screen.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/notification/notification_count.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/payment/payment_list/payment_list.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product_bloc/product_event.dart';
import 'package:webnsoft_solution/modal/checkin_checkout/check_in_status.dart';
import 'package:webnsoft_solution/modal/checkin_checkout/checkin_checkout.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/nav_drawer/navigation_drawer.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({required this.user, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  String checkInOUt = 'Check-In';
  String checkInStatus = 'check_out';
  String checkInOutTime = '';
  CheckInOutRecord? checkInOutRecord;
  CheckInData checkInData = CheckInData();

  bool homeLoading = false;
  bool checkInOutLoading = false;
  List<Customer> customerList = [];
  LocationData? locationData;
  Placemark? placeMark;


  @override
  void initState() {
    context.read<HomeBloc>().add(HomeCheckInStatusEvent());
    context.read<HomeBloc>().add(HomeCustomerFetchEvent());
    context.read<ProductBloc>().add(DeleteCartEvent());
    checkLocation();
    super.initState();
  }
  checkLocation() async{
     locationData =  await checkLocationPermission();
    placeMark = await getAddressFromLatLng(locationData!);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
        actions: const [
          NotificationCount()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ChangeRoutes.openCustomerForOrderScreen(context),
          //  Navigator.pushReplacementNamed(context, addCustomerRoute),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, homeState) {
          if (homeState is HomeLoading) {
            setState(() => homeLoading = true);
          }
          if (homeState is HomeCheckInOutLoading) {
            setState(() => checkInOutLoading = true);
          }
          if (homeState is HomeCheckInOutSuccess) {
           setState(() {
             checkInOutRecord = homeState.checkInOutRecord;
             checkInStatus == 'check_in' ? checkInStatus = 'check_in' : checkInStatus = 'check_out';
           });
          }
          if (homeState is HomeSuccess) {
            checkInOutLoading = false;
            if(homeState.checkInData != null){
              checkInData = homeState.checkInData!;
              if(checkInData.status == 'check_in'){
                checkInOutTime = "${checkInData.date??''} ${checkInData.checkInTime??''}";
                checkInStatus = 'check_in';
              }else{
                checkInOutTime = "${checkInData.date??''} ${checkInData.checkOutTime??''}";
                checkInStatus = 'check_out';
              }
              setState(() {});
            }
            if(homeState.checkInOutRecord != null){
              checkInOutRecord = homeState.checkInOutRecord!;
              if(checkInOutRecord!.status == 'check_in'){
                checkInOutTime = checkInOutRecord!.checkInDatetime??'';//"${checkInData.date??''} ${checkInData.checkInTime ??''}";
                checkInStatus = 'check_in';
              }else{
                checkInOutTime = checkInOutRecord!.checkOutDatetime??'';//"${checkInData.date??''} ${checkInData.checkOutTime??''}";
                checkInStatus = 'check_out';
              }
              setState(() {});
            }
            if(homeState.distributorList != null){
              customerList = homeState.distributorList!;
            }
            setState(() {});
          }
          if(homeState is HomeCheckInOurError){
            ChangeRoutes.unAuthorizedError(context,homeState.error);
            checkInOutLoading = false;
            setState(() {});
          }
        },
        builder: (context, homeState) {
          return homeLoading
              ? const Center(
                  child: CustomProgressBar(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                       Container(
                        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            checkInOutLoading ? Container() :    Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BodyText(
                                  text:  checkInStatus == 'check_in'
                                      ? 'Working Status'//'Check-In'
                                      : 'Working Status',
                                  fontSize: 16.h,
                                ),
                                 BodyText(
                                  text: checkInOutTime,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                )
                              ],
                            ),
                            CustomButton(
                                buttonText: checkInStatus == 'check_in' ? 'Check-Out' : 'Check-In',
                                buttonWidth: 110,
                                buttonHeight: 40,
                                margin: 0,
                                buttonColor: checkInStatus == 'check_in' ? Colors.red : Colors.green,
                                buttonTextSize: 12,
                                showLoading: checkInOutLoading,
                                onClick: ()  {
                                  if(locationData != null){
                                    context.read<HomeBloc>().add(HomeCheckInOutUpdateEvent(checkInOutStatus : checkInStatus,locationData : locationData!,placeMark : placeMark));
                                  }else{
                                    checkLocationPermission();
                                    //snackBar(context, 'No location permission please on your location');
                                  }
                                })
                          ],
                        ),
                      ),
                      Container(
                          decoration: defaultDecoration,
                          margin: EdgeInsets.all(8.h),
                          padding: EdgeInsets.all(10.h),
                          alignment: AlignmentDirectional.topStart,
                          child: const TargetScreen()),
                      showCustomerPayment()
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget showCustomerPayment() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BodyText(
                    text: 'Recent Payment',
                    color: bodyBlack,
                    fontWeight: FontWeight.bold,
                  ),
                  GestureDetector(
                      onTap: () =>  Navigator.pushReplacementNamed(context, paymentListRoute,),
                      child: const BodyText(
                        text: 'View All',
                        fontSize: 12,
                      )),
                ],
              )),

          const PaymentList(fromHome: true),
          Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BodyText(
                    text: 'Recent Customer',
                    color: bodyBlack,
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: () => Navigator.pushReplacementNamed(context, customerListRoute,),
                          icon: const Icon(Icons.search)),
                      GestureDetector(
                          onTap: () =>  Navigator.pushReplacementNamed(context, customerListRoute,),
                          child: const BodyText(
                            text: 'View All',
                            fontSize: 12,
                          )),
                    ],
                  ),
                ],
              )),
          const CustomerList(
            fromHome: true,
          ),
        ],
      ),
    );
  }
}
