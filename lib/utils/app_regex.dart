
import 'package:flutter/services.dart';





class InputFieldFormatter {
  static List<TextInputFormatter> textFormat = [
    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
  ];
  static List<TextInputFormatter> numberFormat = [
    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
  ];
  static List<TextInputFormatter> textFormatWithNumber = [
    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9|\\.,]")),
  ];
  static List<TextInputFormatter> emailTextFormat = [
    FilteringTextInputFormatter.allow(RegExp("[a-z0-9|\\.@]")),
  ];
  static List<TextInputFormatter> panCardNumberFormat = [FilteringTextInputFormatter.allow(RegExp('[A-Z0-9]'))];
  static List<TextInputFormatter> panCardNumberFormat1 = [
    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]{5}[0-9]{4}[A-Z]{1}'))
  ];

}


