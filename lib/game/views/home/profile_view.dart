import 'package:flutter/material.dart';
import '../../../core/database.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DB().getFirstUser().then((user) {
          if (user != null) {
            print("Name: ${user['name']}");
            print("Gender: ${user['gender'] == 0 ? 'Male' : 'Female'}");
          } else {
            print("No user found");
          }
        });
      },
        child: Container(
          color: Colors.amber,
        ));
  }
}
