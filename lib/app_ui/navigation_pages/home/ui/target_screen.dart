import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';



/// ***************
///  widget for showing marketing executive target on home page
/// *****************************************

class TargetScreen extends StatefulWidget {
  const TargetScreen({super.key});

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  List<String> targetList = ['MONTHLY','QUARTERLY','HALF YEARLY','YEARLY'];
  int targetIndex = 0;
  bool? showTarget;
  bool showMonthTarget = true;
  bool showQuarterTarget = false;
  bool showHalfYearTarget = false;
  bool showYearTarget  = false;
  String checkInOUt = 'Check-In';
  bool checkInStatus = false;

  @override
  Widget build(BuildContext context) {
    return   Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Column(
           children: [
            /* CustomButton(buttonText:checkInStatus ? 'Check-In' : 'Check-Out',
                 buttonWidth: 110,
                 buttonHeight: 40,
                 margin: 0,
                 buttonColor: checkInStatus ? Colors.green : Colors.red ,
                 buttonTextSize: 12,
                 onClick: () => setState((){
                   if(checkInStatus){
                     checkInStatus = false;
                   }else{
                     checkInStatus = true;
                   }
                 })),*/
             SizedBox(
               width: 100,
               height: 140,
               child: ListView.builder(
                 itemCount: targetList.length,
                   itemBuilder: (context,index){
                   return GestureDetector(
                     onTap: (){
                       setState(() {
                         targetIndex = index;
                       });
                     },
                     child: Padding(
                         padding:  EdgeInsets.fromLTRB( 0.h,4.h,0,0),
                         child: BodyText(text: targetList[index],
                           fontSize: 14,
                           align: TextAlign.start,
                           fontWeight: FontWeight.bold,
                           color: index == targetIndex ? Colors.green : bodyBlack,),
                       ),
                   );
                   }),
             ),
           ],
         ),
        Expanded(
          flex:  2,
          child:  Stack(
            children: [
              Container(
                height : 171.h,
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 55.h,
                      lineWidth: 10.h,
                      percent: 0.90,
                      backgroundColor: Colors.red,
                      center:  Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BodyText(text: 'Achieved',fontSize: 10.h,color: Colors.deepOrange),
                          BodyText(text: '1000',fontSize: 14.h,color: Colors.deepOrange,fontWeight: FontWeight.bold,)
                        ],
                      ),
                      progressColor: Colors.green,
                    ),
                    Space(height: 40.h,)
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
                              BodyText(text: 'Remaining Target : ',fontSize: 14.h, ),
                              BodyText(text: '4000',fontSize: 14.h,color: Colors.red, ),
                            ],),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                              BodyText(text: 'Total Target : ',fontSize: 14.h,),
                              BodyText(text: '40000',fontSize: 14.h, color: Colors.green,),
                            ],),
                          ],
                        ),
                      )),

            ],
          ),
        ),
      ],
    );
  }
}
