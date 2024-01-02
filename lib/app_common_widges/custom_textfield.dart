import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final String label;
  final TextEditingController controller;
  final bool isPasswordField;
  final List<TextInputFormatter>? inputFormatter;
  final ValueChanged<bool> onTextChange;
  final int? maxLines;
  final int? maxLength;
  final Icon? icon;
  final Function? onClick;
  final bool? editable;
  final bool? isEmail;
  final TextInputAction? textInputAction;
  bool? validate;
  final String? errorMessage;

  CustomTextField(
      {super.key,
      required this.hint,
      required this.label,
      required this.controller,
      this.isPasswordField = false,
      this.inputFormatter,
      this.maxLines,
        this.maxLength,
      this.icon,
      this.onClick,
      this.editable = true,
      this.isEmail = false,
  this.textInputAction,
      this.validate,
      required this.onTextChange,
      this.errorMessage, required
      });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPasswordField ? true : false,
        inputFormatters: widget.inputFormatter,
        maxLines: widget.isPasswordField ? 1 : widget.maxLines,
        minLines: 1,
        enabled: widget.editable,
        textAlign: TextAlign.start,
        maxLength: widget.maxLength??50,
        textInputAction: widget.textInputAction ?? TextInputAction.next ,
        style: theme.bodyLarge!.copyWith(color: bodyBlack),
        decoration: InputDecoration(
          counterText: '',
         contentPadding: const EdgeInsets.fromLTRB(12,16,12, 16),
            hintText: widget.hint,
            hintStyle: theme.bodyLarge!.copyWith(color: bodyLightBlack),
            label: BodyText(text: widget.label, color: bodyLightBlack,),
            labelStyle:theme.bodyLarge!.copyWith(color: bodyLightBlack),
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1, color: bodyLightBlack)),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1, color: primaryColor)),
            suffixIcon: widget.icon != null ? IconButton(
               icon: widget.icon!, onPressed: () => widget.onClick!(),) : widget.icon,
            errorText: widget.validate == true ? widget.errorMessage : null, errorStyle: theme.bodySmall!.copyWith(fontSize: 14,color: Colors.red)),
        onChanged: (value) {
          if (value.isNotEmpty) {
            widget.validate = false;
            widget.onTextChange(widget.validate!);
          } else {
            widget.validate = true;
            widget.onTextChange(widget.validate!);
          }
        },
      ),
    );
  }
}
