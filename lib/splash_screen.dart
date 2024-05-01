import 'dart:async';

import 'package:africrypt/Models/player_model.dart';
import 'package:africrypt/game/views/auth/signin_view.dart';
import 'package:africrypt/game/views/dashboard_view.dart';
import 'package:africrypt/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Widget _homePage = const SignIn();
  late AnimationController _controller;
  Future<void> checkTableAndRedirect() async {
    if (await PlayerModel.loadFromSharedPreferences() != null) {
      setState(() {
        _homePage = const Dashboard();
      });
    }
  }

  bool _showFirstImage = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    checkTableAndRedirect();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )
      ..addListener(() {
        setState(() {});
      })
      ..forward();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => _homePage));
    });
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _showFirstImage = !_showFirstImage;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Africrypt',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 60),
            AnimatedCrossFade(
              duration: const Duration(seconds: 1),
              secondChild:
                  Image.asset('assets/logo/logo.png', width: 150, height: 150),
              firstChild: Image.asset('assets/logo/genuis-game.png',
                  width: 150, height: 150),
              crossFadeState: _showFirstImage
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
            const SizedBox(height: 25),
            const Text('Powered by Genuis Game',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.all(60),
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(3),
                color: globalColor,
                value: _controller.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
