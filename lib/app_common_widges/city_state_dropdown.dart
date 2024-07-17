

import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';
import 'package:webnsoft_solution/modal/city_state_data.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';

class CityStateDropdown extends StatefulWidget {
  final Map<String, List<String>>? cityStateList;
  final ValueChanged<String> onChangeState;
  final ValueChanged<String> onChangeCity;
  final bool? fromLanguage;
  final bool? validate;
  final String? errorMessage;
  final String? selectedCity;
  final String? selectedState;

  const CityStateDropdown({
    this.cityStateList,
    required this.onChangeState,
    required this.onChangeCity,
    this.fromLanguage = false,
    this.validate,
    this.selectedCity,
    this.selectedState,
    this.errorMessage,
    Key? key,
  }) : super(key: key);

  @override
  State<CityStateDropdown> createState() => _CityStateDropdownState();
}

class _CityStateDropdownState extends State<CityStateDropdown> {
  String? _selectedState;
  String? _selectedCity;
  Map<String, List<String>> cityStateList = organizeData(cityStateData);

  @override
  void initState() {
    _selectedCity = widget.selectedCity;
    _selectedState = widget.selectedState;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
              child: DropdownButton(
                dropdownColor: bodyWhite,
                borderRadius: BorderRadius.circular(8),
                isExpanded: true,
                value: _selectedState,
                hint: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: BodyText(
                    text: 'Select State',
                    color: bodyLightBlack,
                  ),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedState = newValue;
                    _selectedCity = null; // Reset city when state changes
                    widget.onChangeState(newValue!);
                  });
                },
                items: cityStateList.keys.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    alignment: AlignmentDirectional.centerStart,
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: BodyText(text: value),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        if (_selectedState != null) ...[
          const SizedBox(height: 10),
          Container(
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
                child: DropdownButton(
                  dropdownColor: bodyWhite,
                  borderRadius: BorderRadius.circular(8),
                  isExpanded: true,
                  value: _selectedCity,
                  hint: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: BodyText(
                      text: 'Select City',
                      color: bodyLightBlack,
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCity = newValue;
                      widget.onChangeCity(newValue!);
                    });
                  },
                  items: cityStateList[_selectedState!]!.map<DropdownMenuItem<String>>((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: BodyText(text: city),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
