import 'package:africrypt/core/theme.dart';
import 'package:flutter/material.dart';

class CheckboxLogin extends StatefulWidget {
  const CheckboxLogin({
    required this.urlPerso,
    required this.isGender,
    required this.onPressed,
    super.key,
  });

  final String urlPerso;
  final bool isGender;
  final void Function(bool?)? onPressed;

  @override
  State<CheckboxLogin> createState() => _CheckboxLoginState();
}

class _CheckboxLoginState extends State<CheckboxLogin> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, setState) => Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(50)),
            child: Image.asset(
              widget.urlPerso,
              scale: 7.0,
            ),
          ),
          Checkbox(
            value: widget.isGender,
            onChanged: widget.onPressed,
            activeColor: GameTheme.mainColor,
          )
        ],
      ),
    );
  }
}
