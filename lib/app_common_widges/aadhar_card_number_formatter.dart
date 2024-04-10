import 'package:flutter/services.dart';

class AadhaarNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll(RegExp(r'\s'), ''); // Remove any existing spaces
    final formattedText = _formatAadharNumber(newText); // Format Aadhar number with spaces
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatAadharNumber(String text) {
    if (text.length < 5) {
      return text;
    } else if (text.length< 9) {
      return '${text.substring(0, 4)} ${text.substring(4)}';
    } else if (text.length <= 12) {
      return '${text.substring(0, 4)} ${text.substring(4, 8)} ${text.substring(8)}';
    } else {
      return '${text.substring(0, 4)} ${text.substring(4, 8)} ${text.substring(8, 12)} ${text.substring(12)}';
    }
  }
}
