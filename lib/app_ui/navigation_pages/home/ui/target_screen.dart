import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/target_bloc/target_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/target_bloc/target_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/target_bloc/target_state.dart';
import 'package:webnsoft_solution/modal/executive/target_modal.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';

/// ***************
///  widget for showing marketing executive target on home page
/// *****************************************

class TargetScreen extends StatefulWidget {
  const TargetScreen({super.key});

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  int targetIndex = 0;
  List<Target> targetList = [];
  bool targetLoading = true;
  String target = '';
  String achieveTarget = '';
  String remainingTarget = '';
  double? percent;
  String error = '' ;

  @override
  void initState() {
    context.read<TargetBloc>().add(TargetFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TargetBloc, TargetState>(
      listener: (context, state) {
        if (state is TargetSuccess) {
          targetLoading = false;
         var myTargetsList = state.targetList;
          if (myTargetsList.isNotEmpty) {
            for (var target in myTargetsList) {
              if(target.type == 'oneMonth' && target.target != '0'){
                targetList.add(Target(type: 'Month',target: target.target,achievedTarget: target.achievedTarget));
              }
              if(target.type == 'quarterlyMonth' && target.target != '0'){
                targetList.add(Target(type: 'Quarterly',target: target.target,achievedTarget: target.achievedTarget));
              }
              if(target.type == 'sixMonth' && target.target != '0'){
                targetList.add(Target(type: 'Half Yearly',target: target.target,achievedTarget: target.achievedTarget));
              }
              if(target.type == 'tweelveMonth' && target.target != '0'){
                targetList.add(Target(type: 'Yearly',target: target.target,achievedTarget: target.achievedTarget));
              }
            }

            target = targetList[0].target.toString();
            achieveTarget = targetList[0].achievedTarget.toString();
            remainingTarget = '${int.parse(target) - int.parse (achieveTarget)}';
            int targetValue = int.parse(target);
            int achieveValue = int.parse(achieveTarget);
            if(achieveValue > targetValue){
              remainingTarget = 'Nice Work';
              percent = 1;
            }else{
              percent = achieveValue/targetValue;
            }

          }
          setState(() {});
        }
        if (state is TargetError) {
          targetLoading = false;
          error = state.error;
          ChangeRoutes.unAuthorizedError(context,state.error);
        }
      },
      builder: (context, state) {
        return error.isNotEmpty ? BodyText(text: error,color: Colors.red,) : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 100,
                  height: 140,
                  child: targetLoading
                      ? const Center(
                          child: CustomProgressBar(),
                        )
                      : ListView.builder(
                          itemCount: targetList.length,
                          itemBuilder: (context, index) {
                            var targetData = targetList[index];

                            return GestureDetector(
                              onTap: () {
                                targetIndex = index;
                                if(targetData.target == '0'){
                                  target = 'Not Target';
                                  achieveTarget = '-';
                                  remainingTarget = '-';
                                }else{
                                  target = targetData.target.toString();
                                  achieveTarget = targetData.achievedTarget.toString();
                                  remainingTarget = '${int.parse(target) - int.parse(achieveTarget)}';
                                  int targetValue = int.parse(target);
                                  int achieveValue = int.parse(achieveTarget);
                                  if(achieveValue > targetValue){
                                    remainingTarget = 'Well Work 👍';
                                    percent = 1;
                                  }else{
                                    percent = achieveValue/targetValue;
                                  }
                                }

                                setState(() {});
                              },
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0.h, 4.h, 0, 0),
                                child: BodyText(
                                  text: targetData.type.toString(),
                                  fontSize: 14,
                                  align: TextAlign.start,
                                  fontWeight: FontWeight.bold,
                                  color: index == targetIndex ? Colors.green : bodyBlack,
                                ),
                              ),
                            );
                          }),
                ),
              ],
            ),
            targetList.isNotEmpty
                ? Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        Container(
                          height: 171.h,
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: [
                              CircularPercentIndicator(
                                radius: 55.h,
                                lineWidth: 10.h,
                                percent: percent??0,
                                backgroundColor: Colors.red,
                                center: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BodyText(
                                        text: 'Achieved',
                                        fontSize: 10.h,
                                        color: Colors.deepOrange),
                                    BodyText(
                                      text: achieveTarget,
                                      fontSize: 14.h,
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold,
                                    )
                                  ],
                                ),
                                progressColor: Colors.green,
                              ),
                              Space(
                                height: 40.h,
                              )
                            ],
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: SizedBox(
                              height: 41.h,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      BodyText(
                                        text: 'Remaining Target : ',
                                        fontSize: 14.h,
                                      ),
                                      BodyText(
                                        text: remainingTarget,
                                        fontSize: 14.h,
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      BodyText(
                                        text: 'Total Target : ',
                                        fontSize: 14.h,
                                      ),
                                      BodyText(
                                        text: target,
                                        fontSize: 14.h,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }

/*
  void generateNewList(List<Target> target) {
    for (var element in target) {
      if(element.type == '' ){
        targetList.add('MONTHLY');
      }
      if(element.quarterlyMonth != null){
        targetList.add('QUARTERLY');
      }
      if(element.sixMonth != null){
        targetList.add('HALF YEARLY');
      }
      if(element.tweelveMonth != null){
        targetList.add('YEARLY');
      }
    }


  }
*/
}
