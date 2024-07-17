import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';

class RowDetailWidget extends StatelessWidget {
  final String titleLeft;
  final String titleRight;
  final String valueLeft;
  final String valueRight;
  final bool? showSingleDetail;

  const RowDetailWidget({required this.titleLeft,required this.titleRight,required this.valueLeft,required this.valueRight,this.showSingleDetail = false,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BodyText(
                text: '$titleLeft : ',fontSize: 16,
              ),
               BodyText(
                 align: TextAlign.start,
                text: valueLeft,
                color: primaryColor,
              ),
            ],
          ),
        ),
      showSingleDetail == true ? Container() :   Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BodyText(text:'$titleRight :',fontSize: 16),
               BodyText(
                 align: TextAlign.start,
                text: valueRight,
                color: primaryColor,
              ),
            ],
          ),
        )
      ],
    );
  }
}
