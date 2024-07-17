import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/custom_progressbar.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/notification/bloc/notification_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/notification/bloc/notification_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/notification/bloc/notification_state.dart';
import 'package:webnsoft_solution/modal/notification/notification_modal.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/change_routes.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  bool notificationLoading = true;

  List<NotificationData> notificationList = [];
  String? errorMessage;

  @override
  void initState() {
    context.read<NotificationBloc>().add(NotificationReadUnreadUpdateEvent());
    context.read<NotificationBloc>().add(NotificationFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        ChangeRoutes.openHomeScreen(context, await getUser());
      },
      child: Scaffold(
        appBar: appBarWidget(context, 'Notification',
            () async => ChangeRoutes.openHomeScreen(context, await getUser())),
        body: BlocConsumer<NotificationBloc, NotificationState>(
          listener: (context, state) {
            if (state is NotificationSuccess) {
              notificationLoading = false;
              notificationList = state.notification!;
              setState(() {});
            }
            if (state is NotificationError) {
              notificationLoading = false;
              ChangeRoutes.unAuthorizedError(context, state.error);
              errorMessage = state.error;
              setState(() {});
            }
          },
          builder: (context, state) {
            return errorMessage != null
                ? Center(
                    child: BodyText(
                      text: errorMessage!,
                      fontSize: 14.h,
                      color: primaryColor,
                    ),
                  )
                : notificationLoading
                    ? const Center(
                        child: CustomProgressBar(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0),
                        itemCount: notificationList.length,
                        itemBuilder: (context, index) {
                          NotificationData data = notificationList[index];
                          return Container(
                              margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.h),
                              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.h),
                              decoration: defaultDecoration,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      BodyText(
                                        text: data.notificationTitle ?? '',
                                        align: TextAlign.start,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      BodyText(
                                        text: data.notificationDate ??
                                            '${data.notificationTime}' ??
                                            '',
                                        align: TextAlign.start,
                                        fontSize: 16,
                                      ),
                                    ],
                                  ),
                                  BodyText(
                                    text: "${data.notificationMessage}" ?? '',
                                    align: TextAlign.start,
                                    fontSize: 16,
                                  ),
                                ],
                              ));
                        },
                      );
          },
        ),
      ),
    );
  }
}
