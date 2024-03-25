import 'package:africrypt/core/database.dart';
import 'package:africrypt/game/views/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/alert.dart';

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
        children: [
          Image.asset(
            'assets/images/welcome.png',
          ),
           Padding(
            padding: EdgeInsets.all(25.0),
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
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(50)),
                      child: Image.asset(
                        'assets/images/perso/boy.png',
                        scale: 7.0,
                      ),
                    ),
                    Checkbox(
                      value: !isGender,
                      onChanged: (newbool) {
                        setState(() {
                          isGender = !newbool!;

                        });
                      },
                      activeColor: const Color(0xffdf2546),
                    )
                  ],
                ),
                // Second character
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(50)),
                      child: Image.asset(
                        'assets/images/perso/girl.png',
                        scale: 7.0,
                      ),
                    ),
                    Checkbox(
                      value: isGender,
                      onChanged: (newbool) {
                        setState(() {
                          isGender = newbool!;
                          print(isGender);
                        });
                      },
                      activeColor: const Color(0xffdf2546),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          GestureDetector(
            onTap: () async {
              final enteredName = nameController.text.trim();
              if(enteredName.isNotEmpty && enteredName.length > 2) {
                DB().insertUser(enteredName, isGender);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Dashboard(),
                  ),
                );
              } else {
                showErrorDialog(context, 'Entrer un pseudo correct');
              }

            },
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xffdf2546),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    const Text(
                      'Confirmer',
                      style: TextStyle(
                          fontWeight: FontWeight.w800, color: Colors.white),
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
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

}
