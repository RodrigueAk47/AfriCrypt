import 'package:africrypt/features/string_feature.dart';
import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/game/components/text_field_component.dart';
import 'package:africrypt/main.dart';
import 'package:africrypt/models/player_model.dart';
import 'package:flutter/material.dart';

import '../../../features/auth_gardian.dart';
import 'login_view.dart';

class RegisterAuth extends StatelessWidget {
  const RegisterAuth({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          margin: screenWidth > 800
              ? EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.2,
                  right: MediaQuery.of(context).size.width * 0.2,
                  top: 25,
                  bottom: 20)
              : const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Je veux m\'enregistrer',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 100),
              TextFieldGame(
                hintText: 'Votre addresse mail',
                controller: emailController,
              ),
              const SizedBox(height: 25),
              TextFieldGame(
                hintText: 'Votre mot de passe',
                controller: passwordController,
              ),
              const SizedBox(height: 25),
              ButtonOne(
                onButtonPressed: () async {
                  if (await isInternetConnected()) {
                    String? email = emailController.text.trim();
                    String? password = passwordController.text.trim();

                    if (!isValidEmail(email)) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: globalColor,
                        content: const Text('Email invalide.'),
                        action: SnackBarAction(
                          label: 'ok',
                          onPressed: () {
                            // Code to execute.
                          },
                        ),
                      ));
                      return;
                    }

                    if (!isValidPassword(password)) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: globalColor,
                        content: const Text('Mot de passe invalide.'),
                        action: SnackBarAction(
                          label: 'ok',
                          onPressed: () {
                            // Code to execute.
                          },
                        ),
                      ));
                      return;
                    }

                    String? errorMessage =
                        (await PlayerModel.signUpWithEmail(email, password));
                    if (errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: globalColor,
                        content: Text(errorMessage),
                        action: SnackBarAction(
                          label: 'ok',
                          onPressed: () {
                            // Code to execute.
                          },
                        ),
                      ));
                    } else {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('Pas de connexion Internet'),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                    ));
                  }
                },
                title: 'Cest bon !',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
