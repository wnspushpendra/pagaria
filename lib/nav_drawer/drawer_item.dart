import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/space.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {Key? key,
      required this.name,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  final String name;
  final String icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding:  EdgeInsets.fromLTRB(20.h, 0, 0, 0),
        child: SizedBox(
          height: 40.h,
          child: Row(
            children: [
               Space(height: 14.h,),
              Image.asset(
                icon,
                color: Colors.white,
                width: 24.h,
                height: 24.h,
              ),
               SizedBox(
                width: 20.h,
              ),
              Text(
                name,
                style:  TextStyle(fontSize: 18.h, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
