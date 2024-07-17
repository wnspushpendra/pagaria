import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomRangeSlider extends StatefulWidget {
  RangeValues rangeValues;
  final ValueChanged<RangeValues> onChange;
   CustomRangeSlider({
     required this.rangeValues,
    required this.onChange,
    Key? key}) : super(key: key);

  @override
  State<CustomRangeSlider> createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: widget.rangeValues,
      min: 18,
      max: 72,
      divisions: 5,
      labels: RangeLabels(
        widget.rangeValues.start.round().toString(),
        widget.rangeValues.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          widget.rangeValues = values;
          widget.onChange(values);
        });
      },
    );
  }
}
