/// *************** regex for valid name ***************

bool isNameValid(String? name) {
  if (name == null) return false;
  final regExp = RegExp('[a-zA-Z]');
  return regExp.hasMatch(name);
}
/// *************** regex for valid panCard number ***************

bool panCardValidator(String panNumber) {
  return RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(panNumber);
}
/// *************** regex for valid gst number ***************
///
bool isValidateGSTNumber(String gstNumber) {
  return RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9A-Z]{1}[0-9]{1}$').hasMatch(gstNumber);
}

/// *************** regex for valid email address  ***************

bool isValidEmail(String email) {
  if (email != null || email.isNotEmpty) {
    final RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    // final RegExp regex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)| (\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(email);
  } else {
    return false;
  }
}

/// *************** regex for valid password length should be min 8 character
/// and allow caps latter and special character   *****************************

bool isValidPassword(String value) {
  var passValid = RegExp("^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*");
  return passValid.hasMatch(value);
}






