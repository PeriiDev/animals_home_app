import 'package:flutter/material.dart';

Future pickDateCalendar(BuildContext context) async {
  final initialDate = DateTime.now();
  final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 20),
      lastDate: DateTime.now() /*DateTime(DateTime.now().year + 1)*/);

  if (newDate == null) return;

  return newDate;
}
