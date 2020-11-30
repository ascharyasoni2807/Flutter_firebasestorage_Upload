import 'package:flutter/material.dart';

InputDecoration textFieldDecoration(String hinttext, String labeltext) {
  return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 3.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[800], width: 1.0),
      ),
      labelText: labeltext,
      // labelStyle: ,
      hintText: hinttext);
}
