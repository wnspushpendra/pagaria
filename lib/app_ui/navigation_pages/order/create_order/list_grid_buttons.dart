
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webnsoft_solution/app_common_widges/custom_button.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';

class ListGridButton extends StatefulWidget {
  bool activeButton;
  ValueChanged<bool> onChange;
   ListGridButton({required this.activeButton,required this.onChange,super.key});

  @override
  State<ListGridButton> createState() => _ListGridButtonState();
}

class _ListGridButtonState extends State<ListGridButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                flex: 1,
                child: CustomButton(
                  onClick: () {
                    widget.onChange(true);
                    },
                  buttonText: 'ListView',
                  radius: 0,
                  margin: 0,
                  buttonTextSize: 14,
                  buttonColor: widget.activeButton ? primaryColor : bodyLightBlack,
                )),
            Expanded(
                flex: 1,
                child: CustomButton(
                  onClick: () {
                    widget.onChange(false);
                  },
                  buttonText: 'GridView',
                  radius: 0,
                  margin: 0,
                  buttonTextSize: 14,
                  buttonColor: widget.activeButton ? bodyLightBlack : primaryColor,
                ))
          ],
        ),
      ],
    );
  }
}
