import 'package:flutter/material.dart';

class TextFieldGame extends StatelessWidget {
  const TextFieldGame({super.key, required this.hintText,  this.controller,  this.obscurText = false});
  final String hintText;
   final bool obscurText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return  TextField(
      obscureText: obscurText,
      decoration:  InputDecoration(
        contentPadding: const EdgeInsets.only(left: 15),
        hintText: hintText,
        filled: true,
        
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide:
          BorderSide(color: Color.fromARGB(255, 175, 181, 181)),
        ),
      ),
      controller: controller,
    );
  }
}
