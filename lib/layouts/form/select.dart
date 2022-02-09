import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';

String value = "None";

Widget select(List<dynamic> data) {
  return SmartSelect<String>.single(
    title: 'Select Mining Area',
    choiceItems: getOptions(data),
    onChange: (state) {
      //setState(() => value = state.value)
    },
    selectedValue: value,
  );
}

List<S2Choice<String>>? getOptions(List<dynamic> data) {
  //return areas;
  /*
  List<S2Choice<String>> options = data
      .map<S2Choice<String>>((e) => S2Choice(value: e.id, title: e.name))
      .toList();*/
  return [];
}
