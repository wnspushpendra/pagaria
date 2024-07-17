import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/notification/bloc/notification_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/notification/bloc/notification_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/notification/bloc/notification_state.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';

class NotificationCount extends StatefulWidget {
  const NotificationCount({super.key});

  @override
  State<NotificationCount> createState() => _NotificationCountState();
}

class _NotificationCountState extends State<NotificationCount> {
  String count = '0';

  @override
  void initState() {
    context.read<NotificationBloc>().add(NotificationCountEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listener: (context, state) {
        if (state is NotificationSuccess) {
          count = state.count!;
          setState(() {});
        }
      },
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 8.h),
        child: Stack(
          children: [
            IconButton(
                onPressed: () => ChangeRoutes.openNotificationScreen(context),
                icon:  Icon(
                  Icons.notifications_active_outlined,
                  color: bodyWhite, size: 24.h,
                )),
             Positioned(
              right: 0,
              child: Container(
                alignment: Alignment.center,
                width: 16.h,height: 16.h,
                decoration: BoxDecoration(
                    color: bodyWhite,
                    borderRadius: BorderRadius.all(Radius.circular(15.h))
                ),
                child: BodyText(text: count,fontSize: 8.h,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
