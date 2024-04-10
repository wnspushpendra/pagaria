import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/modal/distributor_list.dart';
import 'package:webnsoft_solution/modal/firm_customer_modal.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';




class CustomDropDown extends StatefulWidget {
  final String type;
  final String hint;
  final List<String>? itemList;
  final List<Firm>? firmList;
  final List<AllCustomer>? customerList;
  final List<User>? distributorList;
 // final List<Customer>? distributorList;
  final String? selectedValue;
  final Firm? selectedFirmValue;
  final AllCustomer? selectedCustomerValue;
  final User? selectedDistributorValue;
 // final Customer? selectedDistributorValue;
  final ValueChanged<String>? onChangeValue;
  final ValueChanged<Firm>? onChangeFirm;
  final ValueChanged<AllCustomer>? onChangeCustomer;
  final ValueChanged<User>? onChangeDisrtirbutor;
 // final ValueChanged<Customer>? onChangeDisrtirbutor;
  final bool? fromLanguage;
  final bool? validate;
  final String? errorMessage;

  const CustomDropDown(
      {
        required this.type,
        required this.hint,
        this.itemList,
      this.firmList,
        this.distributorList,
      this.customerList,
        this.selectedValue,
      this.selectedFirmValue,
      this.selectedCustomerValue,
        this.selectedDistributorValue,
        this.onChangeValue,
       this.onChangeFirm,
        this.onChangeCustomer,
        this.onChangeDisrtirbutor,
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
            value: widget.selectedFirmValue,
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
          :  widget.type == 'customer' ?
          DropdownButton<AllCustomer>(
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
          )
          : widget.type == 'distributor' ?
          DropdownButton<User>(
            dropdownColor: bodyWhite,
            borderRadius: BorderRadius.circular(8),
            isExpanded: true,
            value: widget.selectedDistributorValue,
            hint: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: BodyText(text: widget.hint, color: bodyLightBlack,),
            ),
            onChanged: (User? newValue) {
              setState(() {
                widget.onChangeDisrtirbutor!(newValue!);
              });
            },
            items: widget.distributorList!.map<DropdownMenuItem<User>>((User value) {
              return DropdownMenuItem<User>(
                alignment: AlignmentDirectional.centerStart,
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: BodyText(text: value.fullName!,),
                ),
              );
            }).toList(),
          )

              :  DropdownButton<String>(
            dropdownColor: bodyWhite,
            borderRadius: BorderRadius.circular(8),
            isExpanded: true,
            value: widget.selectedValue,
            hint: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: BodyText(text: widget.hint, color: bodyLightBlack,),
            ),
            onChanged: (String? newValue) {
              setState(() {
                widget.onChangeValue!(newValue!);
              });
            },
            items: widget.itemList!.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                alignment: AlignmentDirectional.centerStart,
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: BodyText(text: value,),
                ),
              );
            }).toList(),
          )
          ,

        ),
      ),
    );
  }
}
