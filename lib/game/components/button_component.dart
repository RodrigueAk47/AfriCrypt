
import 'package:africrypt/main.dart';
import 'package:flutter/material.dart';

class ButtonOne extends StatelessWidget {
  const ButtonOne({
    super.key,
    required this.onButtonPressed,
    required this.title,
    this.enabled = true,
    this.logo = Icons.arrow_forward,
  });

  final String title;
  final bool enabled;
  final IconData logo;
  final void Function() onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Container(
          decoration: BoxDecoration(
              color: globalColor,
              borderRadius: const BorderRadius.all(Radius.circular(16))),
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 19),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white12),
                  width: 35,
                  height: 35,
                  child: Icon(enabled ? logo : Icons.lock,
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
