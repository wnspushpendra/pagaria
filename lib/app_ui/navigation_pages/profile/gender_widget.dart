import 'package:flutter/material.dart';
import 'package:webnsoft_solution/app_common_widges/app_body_text.dart';

class SelectGender extends StatelessWidget {
  final String gender;
  final ValueChanged<String> onChange;
  const SelectGender({required this.gender,required this.onChange,super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          flex: 1,
          child: RadioListTile(
              title: const BodyText(text: 'Male'),
              value: 'male',
              groupValue: gender,
              onChanged: (value) => onChange(value!)),
        ),
        Expanded(
          flex: 1,
          child: RadioListTile(
              title: const BodyText(text: 'Female'),
              value: 'female',
              groupValue: gender,
              onChanged: (value) => onChange(value!)),
        ),
      ],
    );
  }
}
