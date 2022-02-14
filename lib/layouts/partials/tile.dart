import 'package:flutter/material.dart';

Widget getTile(String title,onTap,{color=Colors.blue}){
  return Card(
    color: color,
    elevation: 4,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.white70, width: 1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        height: 200,
        width: double.infinity,
        child: Center(
          child: Text(title,style: TextStyle(color: Colors.white, fontSize: 24),),
        ),
      ),
    ),
  );
}