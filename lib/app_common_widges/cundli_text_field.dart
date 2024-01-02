import 'package:flutter/material.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';

class CundliTextField extends StatefulWidget {
  final String text;
  final TextEditingController controller;

  const CundliTextField(
      {required this.text, required this.controller, Key? key})
      : super(key: key);

  @override
  State<CundliTextField> createState() => _CundliTextFieldState();
}

class _CundliTextFieldState extends State<CundliTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration:  BoxDecoration(
        border: Border.all(width: 1,color: bodyBlack),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: TextField(
        controller: widget.controller,
      ),
    );
  }
}
