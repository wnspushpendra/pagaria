import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';




class CustomDropDown extends StatefulWidget {
  final String hint;
  final List<String>? itemList;
  final String? selectedValue;
  final ValueChanged<String> onChange;
  final bool? fromLanguage;
  final bool? validate;
  final String? errorMessage;

  const CustomDropDown(
      {required this.hint,
      this.itemList,
      this.selectedValue,
      required this.onChange,
        this.fromLanguage = false,
        this.validate,
        this.errorMessage,
      Key? key})
      : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Colors.black26)),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
              isExpanded: true,
              value: widget.selectedValue,
              hint: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: BodyText(text: widget.hint,color: bodyLightBlack,),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  widget.onChange(newValue!);
                });
              },
              items: widget.itemList!.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  alignment:  AlignmentDirectional.centerStart,
                  value: value,
                  child:Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: BodyText(text: value,),
                  ),
                );
              }).toList()),
        ),
      ),
    );
  }
}
