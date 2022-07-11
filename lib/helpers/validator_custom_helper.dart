import 'package:flutter/material.dart';

class ValidatorCustomHelper {
  static String? validatorNameInput(String? value) {
    if (value == null || value.isEmpty || value == '') {
      return 'No puede estar vacío';
    }
    return null;
  }
  //String? Function(String?)?

  static String? validatorInputEmail(String? email) {
    if (email == null) return null;
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid ? null : 'Email no válido';
  }

  static String? validatorInputPassword(String? value) {
    if (value == null) return null;
    return value.length < 6 ? 'Longitud mínima 6 letras' : null;
  }

  static String? validatorDefault(String? text) {
    if (text == null) return 'No puede estar vacio';
    return text.isEmpty
        ? 'No puede estar vacío'
        : text.length < 4
            ? 'Longitud mínima de 4 caracteres'
            : null;
  }

  static String? validatorEditProfileName(String? text) {
    if (text == null) return 'No puede estar vacio';
    return text.isEmpty
        ? 'No puede estar vacío'
        : text.length < 4
            ? 'Longitud mínima de 4 caracteres'
            : null;
  }

  static String? validatorEditProfilePhone(String? text) {
    if (text == null) return 'No puede estar vacio';
    return text.isEmpty
        ? 'No puede estar vacío'
        : text.length < 4
            ? 'Longitud mínima de 4 caracteres'
            : null;
  }

  static String? validatorNumberic(String? text) {
    if (text == null) return 'No puede estar vacio';
    if (!isNumericUsingRegularExpression(text)) {
      return 'Solo se admiten números';
    }
    return text.isEmpty ? 'No puede estar vacío' : null;
  }

  static bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }
}
