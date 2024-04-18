import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/game/views/auth/login_view.dart';
import 'package:africrypt/models/player_model.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Se Connecter',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 100),
            ButtonOne(
              onButtonPressed: () {},
              title: 'Google',
              logo: Icons.online_prediction,
            ),
            const SizedBox(height: 25),
            ButtonOne(
                onButtonPressed: () {
                  PlayerModel.signInAnonymously();

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                },
                title: 'Passer'),
          ],
        ),
      ),
    );
  }
}
