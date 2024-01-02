import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/heading_text.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';

class TargetWidget  extends StatelessWidget {
  final String targetType;
  final String target;
  final String achievement;
  const TargetWidget ({required this.targetType,required this.target,required this.achievement,super.key});

  @override
  Widget build(BuildContext context) {
    var percent = int.parse(achievement)/int.parse(target);

    return Container(
      padding:  EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: BodyText(text: targetType,align: TextAlign.start,fontSize: 14.h,)),
              Expanded(
                  flex: 1,
                  child: BodyText(text: target,align : TextAlign.start,fontSize: 14.h,) ),
              Expanded(
                  flex: 1,
                  child: BodyText(text: achievement,align : TextAlign.start,fontSize: 14.h,) ),
             /* Expanded(
                  flex: 1,
                  child: LinearPercentIndicator(
                    padding: const EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width*0.17.h,
                    lineHeight: 10.0.h,
                    percent: percent,
                    barRadius:  Radius.circular(10.h),
                    progressColor: Colors.orange,
                  ), ),*/
            ],
          ),
        ],

      ),
    );

  }
}
