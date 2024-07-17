import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/location.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/widgets/bottom_sheet_place_order.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_bloc/order_state.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/checkout/bloc/check_out_bloc.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class CheckoutBottomWidget extends StatefulWidget {
  //final String distributorId;
  final User? distributor;
  final String totalCartAmount;
  final LocationData? locationData;
  final Placemark? placeMark;


  const CheckoutBottomWidget({required this.distributor, required this.totalCartAmount,required this.locationData,required this.placeMark, super.key});

  @override
  State<CheckoutBottomWidget> createState() => _CheckoutBottomWidgetState();
}

class _CheckoutBottomWidgetState extends State<CheckoutBottomWidget> {
  bool orderPlaceLoading = false;
  LocationData? locationData;
  Placemark? placeMark;


  checkLocation() async {
    User user =  await getUser();
    if(user.roleId == '4'){
      locationData = await checkLocationPermission();
      placeMark = await getAddressFromLatLng(locationData!);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    checkLocation();
  }



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderLoading) {
          setState(() => orderPlaceLoading = true);
        }
        if (state is OrderSuccess) {

         // setState(() => orderPlaceLoading = false);
       //   ChangeRoutes.openOrderScreen(context, true);
        }
        if (state is OrderError) {
          orderPlaceLoading = false;
          if(state.error != null){
            snackBar(context, state.error!);
          }
          setState(() {});
        }
      },
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: defaultDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 12.0.h, vertical: 6.h),
                child: BodyText(
                  text: 'Cart Amount : $rupeesSymbol${widget.totalCartAmount}',
                  fontWeight: FontWeight.bold,
                ),
              ),
            CustomButton(
                buttonWidth: MediaQuery.of(context).size.width,
                buttonText: 'Place Order',
                  radius: 0,
                  margin: 0,
                  showLoading: orderPlaceLoading,
              onClick: () async {
                  User user = widget.distributor ?? await getUser();
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return PlaceOrderBottomSheet(user : user,orderTotal: widget.totalCartAmount,);
                      },
                    );
                  });

              },

              /* onClick: () async{
                  User user = await getUser();
                  if(user.roleId == '4'){
                    if (locationData != null) {
                       context.read<OrderBloc>().add(OrderSubmitEvent(
                          distributorId: widget.distributorId,
                          totalAmount: widget.totalCartAmount,
                          locationData: locationData!,
                          placeMark: placeMark));
                    } else {
                      checkLocation();
                    }
                  }else{
                    if(user.roleId == '5'){
                      var address = user.address;
                      var city = user.city;
                      var state = user.state;
                      var zipcode = user.zipCode;
                      if(address == null || city == null || state == null || zipcode == null ){
                      }
                    }
               *//*     context.read<OrderBloc>().add(OrderSubmitEvent(
                        distributorId: widget.distributorId,
                        totalAmount: widget.totalCartAmount,
                        locationData: locationData!,
                        placeMark: placeMark));*//*
                  }
                  }*/
                  ),
            ],
          ),
        );
      },
    );
  }
}
