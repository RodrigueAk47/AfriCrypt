
import 'package:africrypt/features/string_feature.dart';
import 'package:africrypt/game/components/checkbox_component.dart';
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
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Image.asset(
            'assets/images/welcome.png',
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
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
            padding: const EdgeInsets.only(left: 40, right: 40),
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
          ButtonOne(
              title: 'Commencer le jeu',
              onButtonPressed: () async {
                final enteredName = nameController.text.trim().capitalize();
                if (enteredName.isNotEmpty && enteredName.length > 2) {
                  //User user = User(username: enteredName, gender: isGender);

                  //User.insertUser(user);
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
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
