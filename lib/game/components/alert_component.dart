import 'dart:math';

import 'package:africrypt/core/theme.dart';
import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/game/views/dashboard_view.dart';
import 'package:africrypt/game/views/home/play/season_play.dart';
import 'package:africrypt/models/episodes_model.dart';
import 'package:africrypt/models/season_model.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

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

showSuccessDialog(BuildContext context, String successMessage, Season season,
    Episode episode, int lenght) {
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
          blastDirection: -pi / 3,
          // radial value - UP
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
              onButtonPressed: () async {
                Episode.saveLastUnlockedEpisode(season.id, episode.id);
                Episode.saveLastUnlockedEpisodeOnFirebase(
                    season.id, episode.id);
                Episode.getLastUnlockedEpisode(season.id).then(
                  (value) async {
                    if (value == season.episodes.length) {
                      if (lenght != season.id) {
                        Season.saveLastUnlockedSeason(season.id + 1);
                        Season.saveLastUnlockedSeasonOnFirebase(season.id + 1);
                        showSeasonUnlock(
                            context,
                            'La suite du voyage vous attend',
                            'Saison ${season.id + 1}');
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Dashboard(),
                          ),
                          (route) => false,
                        );
                      }
                    } else {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeasonPlay(
                            lenght: lenght,
                            season: season,
                          ),
                        ),
                        (route) => false,
                      );
                    }
                  },
                );
              })
        ],
      );
    },
  );
}

void showErrorDialogAccess(BuildContext context, String message, String title) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        icon: const Icon(Icons.dangerous, size: 50),
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          ButtonOne(
              onButtonPressed: () {
                Navigator.pop(context);
              },
              title: 'OK')
        ],
      );
    },
  );
}

void showSeasonUnlock(BuildContext context, String message, String title) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        icon: const Icon(Icons.lock_open, size: 50),
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          ButtonOne(
              onButtonPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Dashboard(),
                  ),
                  (route) => false,
                );
              },
              title: 'On y va!')
        ],
      );
    },
  );
}

void progress (BuildContext context,) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                backgroundColor: GameTheme.mainColor,
              ),
              Text(" Chargement..."),
            ],
          ),
        ),
      );
    },
  );
}