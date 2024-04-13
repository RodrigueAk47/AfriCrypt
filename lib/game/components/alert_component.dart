import 'dart:math';

import 'package:africrypt/Models/season_model.dart';
import 'package:africrypt/core/theme.dart';
import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/game/views/home/play/season_play.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

void showErrorDialog(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Quelque chose s\'est mal passée'),
        icon: const Icon(
          Icons.error_rounded,
          size: 50,
        ),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}

showSuccessDialog(BuildContext context, String successMessage, Season season) {
  ConfettiController controller =
      ConfettiController(duration: const Duration(seconds: 5));
  controller.play();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: GameTheme.secondaryColor,
        title: Center(child: Text(successMessage)),
        content: ConfettiWidget(
          confettiController: controller,
          blastDirection: -pi / 3, // radial value - UP
          maxBlastForce: 60,
          minBlastForce: 1,
          emissionFrequency: 0.03,
          numberOfParticles: 15,
          gravity: 0.01,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.emoji_events,
                size: 75,
                color: GameTheme.mainColor,
              ),
              Text('Tu as terminé l\'episode'),
              SizedBox(height: 10),
            ],
          ),
        ),
        actions: <Widget>[
          ButtonOne(
            title: 'Suivant!  ',
            onButtonPressed: () {
              
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SeasonPlay(
                    season: season,
                  ),
                ),
                (route) => false,
              );
            },
          )
        ],
      );
    },
  );
}
