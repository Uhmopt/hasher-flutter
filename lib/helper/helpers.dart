import 'package:flutter/services.dart';

bool checkEmail(String str) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(str);
}

bool checkPassword(String str) {
  return RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$").hasMatch(str);
}

bool checkNumber(String str) {
  return RegExp(r"[\d]").hasMatch(str);
}

List<TextInputFormatter> inputNumberFormatter = [
  FilteringTextInputFormatter.allow(RegExp(r"[0-9.-]")),
  TextInputFormatter.withFunction((oldValue, newValue) {
    try {
      final text = newValue.text;
      if (text.isNotEmpty) double.parse(text);
      return newValue;
    } catch (e) {}
    return oldValue;
  }),
];
