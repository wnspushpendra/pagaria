import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool? showIcon;

  const CustomAppbar({
    required this.title,
    required this.onPressed,
    this.showIcon=true,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        automaticallyImplyLeading: showIcon==true?true:false,
        leading: showIcon == true?IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 24,
          ),
          onPressed: () {
            onPressed();
          },
        ) : null,
        titleSpacing: 0,
        title: NormalText(text:title )
    );
  }
}





AppBar appBarWidget(BuildContext context, String title, Function onPressed) =>
    AppBar(
      backgroundColor: primaryColor,
      elevation: 2,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: bodyWhite,
          size: 24,
        ),
        onPressed: () {
          onPressed();
        },
      ),
      titleSpacing: 0,
      title: NormalText(text:title )
    );
