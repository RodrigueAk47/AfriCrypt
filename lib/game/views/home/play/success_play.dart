import 'package:africrypt/game/views/dashboard_view.dart';
import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Félicitations!'),
        automaticallyImplyLeading: false,
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Dashboard()));
        },
        child: const Center(
          child: Text(
            'Vous avez trouvé tous les mots cachés!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
