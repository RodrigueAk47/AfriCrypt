import 'package:africrypt/features/string_feature.dart';
import 'package:africrypt/main.dart';
import 'package:flutter/material.dart';

class ButtonOne extends StatefulWidget {
  const ButtonOne({
    super.key,
    required this.onButtonPressed,
    required this.title,
    this.enabled = true,
    this.logo = Icons.arrow_forward,
    this.loading = false,
  });

  final String title;
  final bool enabled;
  final IconData logo;
  final void Function() onButtonPressed;
  final bool loading;

  @override
  State<ButtonOne> createState() => _ButtonOneState();
}

class _ButtonOneState extends State<ButtonOne>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(int index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        double value = 1.0 - (((_controller.value + (index / 3)) % 1.0));
        return Transform.translate(
          offset: Offset(0, -10 * value),
          child: Container(
            height: 15,
            width: 15,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onButtonPressed,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: globalColor,
              borderRadius: const BorderRadius.all(Radius.circular(16))),
          padding: responsive<EdgeInsets>(
              context,
              EdgeInsets.fromLTRB(
                  16, widget.loading ? 20 : 10, 12, widget.loading ? 20 : 10),
              EdgeInsets.fromLTRB(
                  16, widget.loading ? 19 : 10, 12, widget.loading ? 19 : 10)),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: widget.loading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildDot(0),
                          const SizedBox(width: 7),
                          _buildDot(1),
                          const SizedBox(width: 7),
                          _buildDot(2),
                        ],
                      )
                    : Text(
                        widget.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontSize: 19),
                      ),
              ),
              if (widget.loading == false)
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white12),
                    width: 35,
                    height: 35,
                    child: Icon(widget.enabled ? widget.logo : Icons.lock,
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
