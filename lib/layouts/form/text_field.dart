import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:date_time_picker/date_time_picker.dart';

Widget textField(String label, controller, {icon, required = true}) {
  return TextFormField(
    controller: controller,
    textCapitalization: TextCapitalization.words,
// The validator receives the text that the user has entered.
    decoration: InputDecoration(
// border: OutlineInputBorder(),
        label: Text("${label}"),
        icon: Icon(icon)),
    validator: (value) {
      if (required && (value == null || value.isEmpty)) {
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
        icon: Icon(Icons.card_membership)),
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

Widget cellField(String label, controller, {icon, required = true}) {
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
      print(required);
      if (required) {
        if (value == null || value.isEmpty) {
          return 'Please enter Labour ${label}';
        } else if (value.length < 12) {
          return 'Invalid ${label}';
        }
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
    dateLabelText: label,
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
/*
bool married = false;

Widget marriedField(String label, inputData) {
  return Row(
    children: [
      Text("${label}"),
      Checkbox(
        checkColor: Colors.white,
//    fillColor: MaterialStateProperty.resolveWith(getColor),
        value: married,
        onChanged: (bool? value) {
          married = value!;
          inputData(value);
        },
      )
    ],
  );
}

bool eobi = false;

Widget eobiField(String label, inputData) {
  return Row(
    children: [
      Text("${label}"),
      Checkbox(
        checkColor: Colors.white,
//    fillColor: MaterialStateProperty.resolveWith(getColor),
        value: eobi,
        onChanged: (bool? value) {
          eobi = value!;
          inputData(value);
        },
      )
    ],
  );
}*/
