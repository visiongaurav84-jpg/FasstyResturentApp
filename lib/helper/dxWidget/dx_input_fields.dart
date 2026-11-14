import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_utilities/app_theme.dart';
import '../app_utilities/dx_app_decoration.dart';
class TextFieldWidget extends StatefulWidget {
  String hintText;
  IconData prefixIcon;
  TextEditingController textController;
  TextInputType? inputType;  // Property to handle input type
  bool? obscureText;  // Property to handle input type


  TextFieldWidget({super.key, required this.hintText, required this.prefixIcon, required this.textController,  this.inputType,  this.obscureText,});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child:  TextField(
        controller: widget.textController,
        obscureText: widget.obscureText ?? false,
        cursorColor: Colors.black,
        keyboardType: widget.inputType == TextInputType.number
            ? TextInputType.number
            : TextInputType.text, // Use number for numbers, text for alphabets

        inputFormatters: widget.inputType == TextInputType.number
            ? <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,  // Allow only numbers
        ]
            : null, // No formatter for text, allowing all characters
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey)),
            border: OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(10.0))),
            hintText: widget.hintText,
            prefixIcon: Icon(widget.prefixIcon, color: Colors.grey,),
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
      ),
    );
  }
}

