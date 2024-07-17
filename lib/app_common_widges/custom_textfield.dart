import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_regex.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final String label;
  final TextEditingController controller;
  final ValueChanged<bool>? onTextChange;
  final bool isPasswordField;
  final List<TextInputFormatter>? inputFormatter;
  final int? maxLines;
  final int? maxLength;
  final bool? editable;
  final bool? isEmail;
  final bool? allCaps;
  final bool? isMobile;
  final FocusNode? focusNode;
  final Function? onClick;
  final TextInputAction? textInputAction;
  final Icon? icon;
  final String? errorMessage;
  bool? validate;


  CustomTextField(
      {super.key,
      required this.hint,
      required this.label,
      required this.controller,
       this.onTextChange,
      this.isPasswordField = false,
      this.editable = true,
      this.isEmail = false,
      this.allCaps = false,
        this.isMobile = false,
      this.focusNode,
      this.inputFormatter,
      this.maxLines,
      this.maxLength,
      this.onClick,
      this.textInputAction,
      this.icon,
      this.errorMessage,
      this.validate,
      });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: TextField(
        focusNode: focusNode,
        controller: widget.controller,
        obscureText: widget.isPasswordField ? true : false,
        inputFormatters: widget.inputFormatter,
        maxLines: widget.isPasswordField ? 1 : widget.maxLines ?? 1,
        keyboardType: widget.isMobile==true ? TextInputType.number : TextInputType.text ,
        minLines: 1,
        enabled: widget.editable,
        textAlign: TextAlign.start,
        maxLength: widget.maxLength ?? 50,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        style: theme.bodyLarge!.copyWith(color: bodyBlack),
        textCapitalization: widget.allCaps!
            ? TextCapitalization.characters
            : TextCapitalization.none,
        decoration: InputDecoration(
            counterText: '',
            contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
            hintText: widget.hint,
            hintStyle: theme.bodyLarge!.copyWith(color: bodyLightBlack),
            label: BodyText(
              text: widget.label,
              color: bodyLightBlack,
            ),
            labelStyle: theme.bodyLarge!.copyWith(color: bodyLightBlack),
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: bodyLightBlack)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: primaryColor)),
            suffixIcon: widget.icon != null
                ? IconButton(
                    icon: widget.icon!,
                    onPressed: () => widget.onClick!(),
                  )
                : widget.icon,
            errorText: widget.validate == true ? widget.errorMessage : null,
            errorStyle: theme.bodySmall!.copyWith(
              fontSize: 14,
              color: Colors.red,
            )),
        onChanged: (value) {
          if (value.isNotEmpty) {
            widget.validate = false;
            if(widget.onTextChange != null){
              widget.onTextChange!(widget.validate!);
            }
          } else {
            widget.validate = true;
            if(widget.onTextChange != null){
              widget.onTextChange!(widget.validate!);
            }
          }
        },
      ),
    );
  }
}
