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
