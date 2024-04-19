import 'package:africrypt/features/string_feature.dart';
import 'package:africrypt/game/components/checkbox_component.dart';
import 'package:africrypt/models/player_model.dart';
import 'package:flutter/material.dart';

import '../../components/alert_component.dart';
import '../../components/button_component.dart';
import '../dashboard_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController nameController = TextEditingController();
  bool isGender = false;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            margin:
                EdgeInsets.only(top: responsive<double>(screenWidth, 25, 0)),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              child: Image.asset(
                'assets/images/${responsive<String>(screenWidth, 'saison1', 'welcome')}.png',
                height: screenWidth > 800 ? 450 : null,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: responsive<double>(screenWidth, 25, 7),
                bottom: responsive<double>(screenWidth, 25, 25),
                left: responsive<double>(screenWidth, 300, 25),
                right: responsive<double>(screenWidth, 300, 25)),
            child: Form(
              child: TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15),
                  hintText: 'Entrez votre pseudo',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 175, 181, 181)),
                  ),
                ),
                controller: nameController,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: responsive<double>(screenWidth, 300, 40),
                right: responsive<double>(screenWidth, 300, 40)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CheckboxLogin(
                    urlPerso: 'assets/images/perso/boy.png',
                    isGender: !isGender,
                    onPressed: (newbool) {
                      setState(() {
                        isGender = !newbool!;
                      });
                    }),
                CheckboxLogin(
                    urlPerso: 'assets/images/perso/girl.png',
                    isGender: isGender,
                    onPressed: (newbool) {
                      setState(() {
                        isGender = newbool!;
                      });
                    }),

                // Second character
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            margin: EdgeInsets.only(
                left: responsive<double>(screenWidth, 200, 40),
                right: responsive<double>(screenWidth, 200, 40)),
            child: ButtonOne(
                title: 'Commencer le jeu',
                onButtonPressed: () async {
                  final enteredName = nameController.text.trim().capitalize();
                  if (enteredName.isNotEmpty && enteredName.length > 2) {
                    PlayerModel player =
                        PlayerModel(name: enteredName, gender: isGender);
                    player.saveToSharedPreferences();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Dashboard(),
                      ),
                    );
                  } else {
                    showErrorDialog(context, 'Entrer un pseudo correct');
                  }
                }),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
