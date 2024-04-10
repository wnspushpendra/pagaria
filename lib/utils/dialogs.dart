
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/app_common_widges/heading_text.dart';
import 'package:webnsoft_solution/app_common_widges/home_appbar.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/logout_bloc/logout_bloc.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/logout_bloc/logout_event.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/logout_bloc/logout_state.dart';
import 'package:webnsoft_solution/routes/route_constatns.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_message.dart';
import 'package:webnsoft_solution/utils/app_preferences.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/asset_images.dart';
import 'package:webnsoft_solution/utils/util_methods.dart';

Future<bool> onBackNavigationScreen(BuildContext context) async {
  return (await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const NormalText(
        text: exitApp,
        color: primaryColor,
      ),
      content: const NormalText(
        text: exitWarning,
        color: bodyBlack,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const NormalText(
            text: no,
            color: bodyLightBlack,
          ),
        ),
        TextButton(
          onPressed: () {
            SystemNavigator.pop();
            Navigator.of(context).pop(true);
          },
          child: const NormalText(
            text: yes,
            color: bodyBlack,
          ),
        ),
      ],
    ),
  )) ??
      false;
}


Future<void> logoutDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title:  const HeadingText(text: logout,fontSize: 20,),
        content: const SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BodyText(text: logoutWarningMessage,align: TextAlign.start,),
            ],
          ),
        ),
        actions: <Widget>[
          BlocConsumer<LogoutBloc,LogoutState>(
              listener: (context,states) async {
                if(states is LogoutSuccess) {
                } else if (states is LogoutError){
                  snackBar(context,states.error);
                }
              },
              builder: (context,state){
                return TextButton(
                  child: const Text(yes),
                  onPressed: () async {
                    context.read<LogoutBloc>().add(LogoutClickEvent());
                    clearPref();
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, loginRoute);
                    snackBar(context,logoutMessage);
                  },
                );
              }),
          TextButton(
            child: const Text(no),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget imageDialog( path, context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      /*  Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close_rounded),
                color: Colors.redAccent,
              ),
            ],
          ),
        ),*/
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.98,
          height: MediaQuery.of(context).size.height * 0.50,
          child: CachedNetworkImage(
            imageUrl: path,
            fit: BoxFit.cover,
          ),
        ),
      ],
    ),
  );
}
