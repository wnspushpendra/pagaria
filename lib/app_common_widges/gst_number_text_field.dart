import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';

class CustomerGstNumberTextField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<bool> onTextChange;
  final String? errorMessage;
  final bool? editable;
  bool? validate;

  CustomerGstNumberTextField(
      {required this.controller,
      required this.validate,
      required this.errorMessage,
      required this.onTextChange,
        this.editable = true,
        super.key});

  @override
  State<CustomerGstNumberTextField> createState() => _CustomerGstNumberTextFieldState();
}

class _CustomerGstNumberTextFieldState extends State<CustomerGstNumberTextField> {
  var keyboardType = TextInputType.number;
  final FocusNode _focusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: TextFormField(
          controller: widget.controller,
          maxLength: 15,
          enabled: widget.editable,
          style: theme.bodyLarge!.copyWith(color: bodyBlack),
          decoration: InputDecoration(
              counterText: '',
              contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
              hintText: gstNumber,
              hintStyle: theme.bodyLarge!.copyWith(color: bodyLightBlack),
              label: const BodyText(
                text: gstNumber,
                color: bodyLightBlack,
              ),
              labelStyle: theme.bodyLarge!.copyWith(color: bodyLightBlack),
              border: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: bodyLightBlack)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: primaryColor)),
              errorText: widget.validate == true ? widget.errorMessage : null,
              errorStyle: theme.bodySmall!.copyWith(
                fontSize: 14,
                color: Colors.red,
              )),
          focusNode: _focusNode,
          textCapitalization: TextCapitalization.characters,
          keyboardType: keyboardType,
          onChanged: (value) {
            if (value.isEmpty) {
              widget.onTextChange(widget.validate == false);
              if(keyboardType != TextInputType.number){
                FocusScope.of(context).unfocus();
                setState(() {
                  keyboardType = TextInputType.number;
                });
                Future.delayed(const Duration(milliseconds: 150)).then((value) {
                  FocusScope.of(context).requestFocus();
                });
              }
              Future.delayed(const Duration(milliseconds: 150)).then((value) {
                FocusScope.of(context).requestFocus();
              });
            }else{
              widget.validate = false;
              widget.onTextChange(widget.validate!);
              setState(() {});

            }
            if(value.length == 1){
              setKeyboardType(TextInputType.number, context);
            }

            if(value.length == 2){
              setKeyboardType(TextInputType.text, context);

             }
            if(value.length == 6){
              setKeyboardType(TextInputType.text, context);

            }
            if (value.length == 7) {
              setKeyboardType(TextInputType.number, context);

            }
            if (value.length == 10) {
              setKeyboardType(TextInputType.number, context);

            }

            if (value.length == 11) {
              setKeyboardType(TextInputType.text, context);

            }
            if(value.length == 12){
              setKeyboardType(TextInputType.number, context);

            }
            if (value.length == 13) {
              setKeyboardType(TextInputType.text, context);

            }
            if (value.length == 14) {
              setKeyboardType(TextInputType.number, context);

            }
            if (value.length == 15) {
                FocusScope.of(context).unfocus();
            }
          }),
    );
  }

  void setKeyboardType(TextInputType desiredKeyboardType, BuildContext context) {
    if (keyboardType != desiredKeyboardType) {
      FocusScope.of(context).unfocus();
      setState(() {
        keyboardType = desiredKeyboardType;
      });
      Future.delayed(const Duration(milliseconds: 150)).then((value) {
        FocusScope.of(context).requestFocus();
      });
    }
  }

}
