import 'package:africrypt/main.dart';
import 'package:flutter/material.dart';

class TextGame extends StatelessWidget {
  const TextGame(
      {required this.isSelect,
      required this.letter,
      super.key,
      required this.onTap});

  final String letter;
  final bool isSelect;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        child: Container(
            width: 55,
            height: 55,
            margin: const EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                color: (isSelect) ? globalColor : Colors.white,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                letter,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: (isSelect) ? Colors.white : Colors.blue),
              ),
            )));
  }
}

class SelectedGame extends StatelessWidget {
  const SelectedGame({required this.letter, super.key, required this.onTap});

  final String letter;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 5,
              left: 13,
              right: 13,
            ),
            child: Text(
              letter,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            )));
  }
}
