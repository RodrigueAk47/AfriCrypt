import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LoginView extends StatefulWidget {
   const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isBoy = false;
  bool isGirl = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            'assets/images/welcome.png',
          ),
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Form(
              child: TextField(
                decoration: InputDecoration(
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
                      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(50)),
                        child: Image.asset('assets/images/perso/boy.png', scale:7.0,),

                    ),
                    Checkbox(value: isBoy, onChanged: (newbool) {
                      setState(() {
                        isBoy=newbool!;
                        isGirl = !newbool;

                      });
                    })
                  ],
                ),
                // Second character
                Column(
                  children: [

                    Container(
                      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(50)),
                        child: Image.asset('assets/images/perso/girl.png', scale:7.0,),

                    ),
                    Checkbox(value: isGirl, onChanged: (newbool) {
                      setState(() {
                        isGirl=newbool!;
                        isBoy = !newbool;
                      });
                    })
                  ],
                ),


              ],
                       ),
           ),
          const SizedBox(height: 20.0),
          GestureDetector(
            onTap: () {
              print('valide');
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xfffb335b),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    const Text(
                      'Valide',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
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
        ],
      ),
    );
  }
}
