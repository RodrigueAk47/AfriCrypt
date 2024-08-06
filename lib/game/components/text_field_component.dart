import 'package:flutter/material.dart';

class TextFieldGame extends StatelessWidget {
  const TextFieldGame(
      {super.key,
      required this.hintText,
      this.controller,
      this.obscurText = false});
  final String hintText;
  final bool obscurText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextField(
        obscureText: obscurText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 15),
          hintText: hintText,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          filled: true,
          fillColor: const Color.fromARGB(109, 255, 255, 255),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(color: Color.fromARGB(255, 175, 181, 181)),
          ),
        ),
        controller: controller,
      ),
    );
  }
}
