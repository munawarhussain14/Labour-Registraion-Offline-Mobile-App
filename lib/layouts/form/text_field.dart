import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:date_time_picker/date_time_picker.dart';

Widget textField(String label, controller,{icon}) {
  return TextFormField(
    controller: controller,
    // The validator receives the text that the user has entered.
    decoration: InputDecoration(
        // border: OutlineInputBorder(),
        label: Text("${label}"),
        icon:Icon(icon)
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter Labour ${label}';
      }
      return null;
    },
  );
}

Widget cnicField(String label, controller) {
  var maskFormatter = new MaskTextInputFormatter(
      mask: '#####-#######-#',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.number,
    inputFormatters: [maskFormatter],
    // The validator receives the text that the user has entered.
    decoration: InputDecoration(
        // border: OutlineInputBorder(),
        label: Text("${label}"),
        hintText: "00000-0000000-0",
        icon: Icon(Icons.card_membership)
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter Labour ${label}';
      } else if (value.length < 15) {
        return 'Invalid ${label}';
      }
      return null;
    },
  );
}

Widget cellField(String label, controller) {
  var maskFormatter = new MaskTextInputFormatter(
      mask: '####-#######',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.number,
    inputFormatters: [maskFormatter],
    // The validator receives the text that the user has entered.
    decoration: InputDecoration(
        // border: OutlineInputBorder(),
        label: Text("${label}"),
        hintText: "0300-0000000",
        icon: Icon(Icons.phone)),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter Labour ${label}';
      } else if (value.length < 15) {
        return 'Invalid ${label}';
      }
      return null;
    },
  );
}

Widget dateField(String label, inputValue) {
  return DateTimePicker(
    initialValue: '',
    firstDate: DateTime(1950),
    lastDate: DateTime(2100),
    dateLabelText: 'Date',
    icon: Icon(Icons.calendar_today),
    onChanged: (val) {
      print(val);
      inputValue(val);
    },
    validator: (val) {
      print(val);
      return null;
    },
    onSaved: (val) => print(val),
  );
}
