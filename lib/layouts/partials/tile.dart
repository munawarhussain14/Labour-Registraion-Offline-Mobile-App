import 'package:flutter/material.dart';

Widget getTile(String title,onTap){
  return Card(
    child: InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Center(
          child: Text(title,style: TextStyle(color: Colors.black54, fontSize: 18),),
        ),
      ),
    ),
  );
}