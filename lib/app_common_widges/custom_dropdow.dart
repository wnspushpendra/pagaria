import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/modal/firm_customer_modal.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';




class CustomDropDown extends StatefulWidget {
  final String type;
  final String hint;
  final List<Firm>? firmList;
  final List<AllCustomer>? customerList;
  final Firm? selectedValue;
  final AllCustomer? selectedCustomerValue;
  final ValueChanged<Firm>? onChangeFirm;
  final ValueChanged<AllCustomer>? onChangeCustomer;
  final bool? fromLanguage;
  final bool? validate;
  final String? errorMessage;

  const CustomDropDown(
      {
        required this.type,
        required this.hint,
      this.firmList,
      this.customerList,
      this.selectedValue,
      this.selectedCustomerValue,
       this.onChangeFirm,
        this.onChangeCustomer,
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
        border: Border.all(color: Colors.black26),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: widget.type == 'firm' ?
          DropdownButton<Firm>(
            dropdownColor: bodyWhite,
            borderRadius: BorderRadius.circular(8),
            isExpanded: true,
            value: widget.selectedValue,
            hint: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: BodyText(text: widget.hint, color: bodyLightBlack,),
            ),
            onChanged: (Firm? newValue) {
              setState(() {
                widget.onChangeFirm!(newValue!);
              });
            },
            items: widget.firmList!.map<DropdownMenuItem<Firm>>((Firm value) {
              return DropdownMenuItem<Firm>(
                alignment: AlignmentDirectional.centerStart,
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: BodyText(text: value.firmName!,),
                ),
              );
            }).toList(),
          )
          :   DropdownButton<AllCustomer>(
            dropdownColor: bodyWhite,
            borderRadius: BorderRadius.circular(8),
            isExpanded: true,
            value: widget.selectedCustomerValue,
            hint: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: BodyText(text: widget.hint, color: bodyLightBlack,),
            ),
            onChanged: (AllCustomer? newValue) {
              setState(() {
                widget.onChangeCustomer!(newValue!);
              });
            },
            items: widget.customerList!.map<DropdownMenuItem<AllCustomer>>((AllCustomer value) {
              return DropdownMenuItem<AllCustomer>(
                alignment: AlignmentDirectional.centerStart,
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: BodyText(text: value.fullName!,),
                ),
              );
            }).toList(),
          ),

        ),
      ),
    );
  }
}
