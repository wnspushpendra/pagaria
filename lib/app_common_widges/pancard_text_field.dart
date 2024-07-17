
import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';

class CustomPanCardField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<bool> onTextChange;
  final String? errorMessage;
  final bool? editable;
  bool? validate;

  CustomPanCardField(
      {required this.controller,
      required this.validate,
       this.errorMessage,
      required this.onTextChange,
        this.editable = true,
        super.key});

  @override
  State<CustomPanCardField> createState() => _CustomPanCardFieldState();
}

class _CustomPanCardFieldState extends State<CustomPanCardField> {
  var keyboardType = TextInputType.text;
  final FocusNode _focusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: TextFormField(
          controller: widget.controller,
          maxLength: 10,
          enabled: widget.editable,
          style: theme.bodyLarge!.copyWith(color: bodyBlack),
          decoration: InputDecoration(
              counterText: '',
              contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
              hintText: panCardNumber,
              hintStyle: theme.bodyLarge!.copyWith(color: bodyLightBlack),
              label: const BodyText(
                text: panCardNumber,
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
             // widget.onTextChange(widget.validate == false);
              FocusScope.of(context).unfocus();
              setState(() {
                keyboardType = TextInputType.text;
              });
              Future.delayed(const Duration(milliseconds: 150)).then((value) {
                FocusScope.of(context).requestFocus();
              });
            }else{
              /*widget.validate = false;
              widget.onTextChange(widget.validate!);
              setState(() {});*/

            }
             if(value.length == 4){
               setKeyboardType(TextInputType.text, context);

               /*if(keyboardType != TextInputType.text){
                 FocusScope.of(context).unfocus();
                 setState(() {
                   keyboardType = TextInputType.text;
                 });
                 Future.delayed(const Duration(milliseconds: 150)).then((value) {
                   FocusScope.of(context).requestFocus();
                 });
               }*/
             }
            if (value.length == 5) {
              setKeyboardType(TextInputType.number, context);
              /* if(keyboardType != TextInputType.number){
                FocusScope.of(context).unfocus();
                setState(() {
                  keyboardType = TextInputType.number;
                });
                Future.delayed(const Duration(milliseconds: 150)).then((value) {
                  FocusScope.of(context).requestFocus();
                });
              }*/

            }
            if (value.length == 8) {
              setKeyboardType(TextInputType.number, context);

              /* if (keyboardType != TextInputType.number) {
                FocusScope.of(context).unfocus();
                setState(() {
                  keyboardType = TextInputType.number;
                });
                Future.delayed(const Duration(milliseconds: 150)).then((value) {
                  FocusScope.of(context).requestFocus();
                });
              }*/
            }
            if (value.length == 9) {
              setKeyboardType(TextInputType.text, context);

             /* if (keyboardType != TextInputType.text) {
                FocusScope.of(context).unfocus();
                setState(() {
                  keyboardType = TextInputType.text;
                });
                Future.delayed(const Duration(milliseconds: 150)).then((value) {
                  FocusScope.of(context).requestFocus();
                });
              } */
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
