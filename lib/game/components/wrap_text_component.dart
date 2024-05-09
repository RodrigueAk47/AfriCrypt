import 'package:flutter/material.dart';

class WrapText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight? fontWeights;
  const WrapText(
      {super.key,
      required this.text,
      this.size = 30,
      this.fontWeights = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 6, left: 6),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child:
          Text(text, style: TextStyle(fontSize: size, fontWeight: fontWeights)),
    );
  }
}
