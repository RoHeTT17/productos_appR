import 'package:flutter/material.dart';

class InputDecorations{

    static InputDecoration authInputDecorations({required String pHintText,required String pLabelText,IconData? pPrefixIcon}) {

      return InputDecoration(
          enabledBorder: const  UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.deepPurple
              )
          ),
          //Al estar el foco en el textfield cambia a este formato
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.deepOrange,
                  width: 2.0
              )
          ),
          hintText:  pHintText,
          labelText: pLabelText,
          labelStyle: const TextStyle(color: Colors.grey),
          prefixIcon: pPrefixIcon != null
                      ? Icon(pPrefixIcon, color: Colors.deepPurple,)
                      : null

          //Icon(Icons.alternate_email_sharp, color: Colors.deepPurple,)
      );

    }

}