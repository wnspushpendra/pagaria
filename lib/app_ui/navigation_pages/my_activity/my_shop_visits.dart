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
import 'package:webnsoft_solution/modal/executive/my_activity_modal/visites_by_date.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class MyShopVisitActivity extends StatefulWidget {
  const MyShopVisitActivity({super.key});

  @override
  State<MyShopVisitActivity> createState() => _MyShopVisitActivityState();
}

class _MyShopVisitActivityState extends State<MyShopVisitActivity> {
  List<MyActivityData> myVisitList = [];
  List<MyVisitByDate> myVisitsByDs = [];
  String? errorMessage;
  bool loading = true;

  @override
  void initState() {
    context.read<MyActivityBloc>().add(FetchMyActivityEvent(fromShopVisit: true));
    super.initState();
  }

  List<MyVisitByDate> transformData(List<MyActivityData> myVisitList) {
    // Map to hold the grouped data by date
    Map<String, List<MyActivityData>> dateMap = {};

    // Iterate over each item in the original list and group by date
    for (var item in myVisitList) {
      String date = item.date!;
      if (!dateMap.containsKey(date)) {
        dateMap[date] = [];
      }
      dateMap[date]!.add(item);
    }




    // Create the new formatted list
    List<Map<String, dynamic>> newList = [];

    dateMap.forEach((date, items) {
      myVisitsByDs.add(MyVisitByDate(date: date, dateByData: items));
    });

    dateMap.forEach((date, items) {
      newList.add({

        "date": date,
        "date_by_data": items.map((item) => item.toMap()).toList(),
      });
    });

    return myVisitsByDs;
  }



  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked : (didPop) async{
        ChangeRoutes.openHomeScreen(context, await getUser());      },
      child: Scaffold(
        appBar: appBarWidget(context, 'My Shop Visits',
            () async => ChangeRoutes.openHomeScreen(context, await getUser())),
        body: BlocConsumer<MyActivityBloc, MyActivityState>(
          listener: (context, state) {
            if (state is MyActivitySuccess) {
              loading = false;
              myVisitList = state.myActivity;
              myVisitsByDs = transformData(myVisitList);

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
                        itemCount: myVisitsByDs.length,
                        itemBuilder: (context, index) {
                          MyVisitByDate data = myVisitsByDs[index];
                          List<MyActivityData> activityData = data.dateByData!;
                       //   bool checkIn = data.status == 'check_out';
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(left: 12.h,top: 8.h),
                                child: BodyText(text: "${getDDMMYYYYDateStringDate(data.date!)} - ${getDayName(data.date!)}" ,fontSize: 20.h,fontWeight: FontWeight.bold,),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:  activityData.length,
                                  itemBuilder: (context,index){
                                  MyActivityData item = activityData[index];
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
                                                    BodyText(text: 'Date',fontSize: 16.h,),
                                                    BodyText(
                                                      text: item.date != null
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
                                                    BodyText(text: 'Visit Time',fontSize: 14.h,),
                                                    BodyText(text: item.checkInTime ?? 'NA',fontSize: 16.h,color: Colors.green,fontWeight: FontWeight.bold,),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Space(height: 2.h,),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              BodyText(text: 'CheckIn Address: ',fontSize: 14.h,align: TextAlign.start,),
                                              Flexible(child: BodyText(text: '${item.addressCheckin} ${item.zipCodeCheckin} ',fontSize: 16.h,align: TextAlign.start,)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),

                            ],
                          );
                        });
          },
        ),
      ),
    );
  }
}
