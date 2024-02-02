import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/custom_appbar.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, 'Notification', () => backUserHome(context)),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: 10,
            itemBuilder: (context,index){
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BodyText(text: 'Notification $index',align: TextAlign.start,fontSize: 16,fontWeight: FontWeight.bold,),
                    const BodyText(text: '10-12-2024',align: TextAlign.start,fontSize: 16,),
                  ],
                ),
                subtitle: const Flexible(child: BodyText(text: 'Simple shot description  for notification list with flex data  ',align: TextAlign.start,fontSize: 16,)),
              );
            }),
      ),
    );
  }
}
