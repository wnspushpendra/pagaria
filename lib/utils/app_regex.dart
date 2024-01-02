
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
  static List<TextInputFormatter> panCardNumberFormat = [
    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]'))
  ];


  bool isValidEmail(String email) {
    if (email.isNotEmpty) {
      final RegExp regex = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      return regex.hasMatch(email);
    } else {
      return false;
    }
  }

  bool isValidAadharNumber(String aadharNumber) {
    return RegExp(r'^[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}$').hasMatch(aadharNumber);
  }

  bool panCardValidator(String panNumber) {
    return RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(panNumber);
  }

  bool drivingLicenseValidator(String drivingLicenceNumber) {
    return RegExp(r'^(([A-Z]{2}[0-9]{2})( )|([A-Z]{2}-[0-9]{2}))((19|20)[0-9][0-9])[0-9]{7}$').hasMatch(drivingLicenceNumber);
  }
}


