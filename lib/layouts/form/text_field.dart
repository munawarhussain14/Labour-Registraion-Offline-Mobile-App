import 'package:flutter/material.dart';

Widget textField(String label,controller){
  return TextFormField(
    controller: controller,
    // The validator receives the text that the user has entered.
    decoration: InputDecoration(
      // border: OutlineInputBorder(),
        label: Text("${label}")
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter Labour ${label}';
      }
      return null;
    },
  );
}