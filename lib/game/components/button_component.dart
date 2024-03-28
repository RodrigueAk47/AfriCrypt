import 'package:africrypt/core/theme.dart';
import 'package:flutter/material.dart';

class ButtonOne extends StatelessWidget {
  const ButtonOne({super.key, required this.onButtonPressed});
  final void Function() onButtonPressed;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onButtonPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Container(
          decoration: const BoxDecoration(
              color: GameTheme.mainColor,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              const Text(
                'C\'est parti !',
                style: TextStyle(
                    fontWeight: FontWeight.w800, color: Colors.white, fontSize: 19),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xff85162a)),
                  width: 35,
                  height: 35,
                  child: const Icon(Icons.arrow_forward,
                      color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
