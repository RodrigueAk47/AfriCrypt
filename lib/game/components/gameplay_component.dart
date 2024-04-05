import 'package:africrypt/core/theme.dart';
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
            decoration: BoxDecoration(
                color: (isSelect)
                    ? GameTheme.mainColor
                    : const Color.fromARGB(255, 181, 172, 172),
                borderRadius: BorderRadius.circular(10)),
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
            child: Text(
              letter,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: (isSelect) ? Colors.white : Colors.blue),
            )));
  }
}

class SelectedGame extends StatelessWidget {
  const SelectedGame({required this.letter, super.key});

  final String letter;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 220, 220, 220),
                borderRadius: BorderRadius.circular(10)),
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
