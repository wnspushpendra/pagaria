import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/my_activity/bloc/my_activity_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/my_activity/bloc/my_activity_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/my_activity/bloc/my_activity_state.dart';
import 'package:webnsoft_solution/modal/executive/my_activity_modal/my_activity_modal.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class UserActivity extends StatefulWidget {
  const UserActivity({super.key});

  @override
  State<UserActivity> createState() => _UserActivityState();
}

class _UserActivityState extends State<UserActivity> {
  List<MyActivityData> myActivityList = [];
  String? errorMessage;
  bool loading = true;

  @override
  void initState() {
    context.read<MyActivityBloc>().add(FetchMyActivityEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked : (didPop) async{
        ChangeRoutes.openHomeScreen(context, await getUser());      },
      child: Scaffold(
        appBar: appBarWidget(context, 'My Activity',
            () async => ChangeRoutes.openHomeScreen(context, await getUser())),
        body: BlocConsumer<MyActivityBloc, MyActivityState>(
          listener: (context, state) {
            if (state is MyActivitySuccess) {
              loading = false;
              myActivityList = state.myActivity;
            }
            if (state is MyActivityError) {
              loading = false;
              errorMessage = state.error;
              //snackBar(context, errorMessage!);
            }
          },
          builder: (context, state) {
            return loading
                ? const Center(
                    child: CustomProgressBar(),
                  )
                : errorMessage != null
                    ? Center(
                        child: BodyText(
                          text: errorMessage!,
                        ),
                      )
                    : ListView.builder(
                        itemCount: myActivityList.length,
                        itemBuilder: (context, index) {
                          MyActivityData data = myActivityList[index];
                          bool checkIn = data.status == 'check_out';
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.h),
                            padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.h),
                            decoration: defaultDecoration,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                           BodyText(text: 'Date',fontSize: 14.h,),
                                          BodyText(
                                              text: data.date != null
                                                  ? getDDMMYYYYDateStringDate(
                                                      data.date!)
                                                  : '',fontSize: 16.h,fontWeight: FontWeight.bold,),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                           BodyText(text: 'Working hours',fontSize: 14.h,),
                                          BodyText(
                                              text: data.totalWorkingTime != null ? getHHMMFromHHMMSS(data.totalWorkingTime!) : '',fontSize: 16.h,fontWeight: FontWeight.bold,),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                           BodyText(text: 'Check In Time',fontSize: 14.h,),
                                          BodyText(text: data.checkInTime ?? 'NA',fontSize: 14.h,color: Colors.green,fontWeight: FontWeight.bold,),
                                        ],
                                      ),
                                    ),
                                   Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                           BodyText(text: 'Check Out Time',fontSize: 14.h,),
                                          BodyText(text: data.checkOutTime ?? '00:00',fontSize: 14.h,color: primaryColor,fontWeight: FontWeight.bold,),
                                        ],
                                      ),
                                    ) ,
                                  ],
                                ),
                                Space(height: 2.h,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    BodyText(text: 'CheckIn Address: ',fontSize: 13.h,align: TextAlign.start,),
                                     Flexible(child: BodyText(text: '${data.addressCheckin} ${data.zipCodeCheckin} ',fontSize: 16.h,align: TextAlign.start,)),
                                  ],
                                ),
                                Space(height: 2.h,),
                                !checkIn ? Container() : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BodyText(text: 'CheckOut Address: ',fontSize: 13.h,align: TextAlign.start,color: primaryColor,),
                                     Flexible(child: BodyText(text: checkIn ? '${data.addressCheckout} ${data.zipCodeCheckout}' : 'NA' , fontSize: 13.h,align: TextAlign.start,)),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
          },
        ),
      ),
    );
  }
}
