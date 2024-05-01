import 'dart:math';

import 'package:africrypt/Models/game_model.dart';
import 'package:africrypt/Models/player_model.dart';
import 'package:africrypt/core/theme.dart';
import 'package:africrypt/features/string_feature.dart';
import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/game/views/dashboard_view.dart';
import 'package:africrypt/game/views/home/play/season_play.dart';
import 'package:africrypt/main.dart';
import 'package:africrypt/models/episodes_model.dart';
import 'package:africrypt/models/season_model.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.emoji_events,
                size: 75,
                color: globalColor,
              ),
              const Text('Tu as terminé l\'episode'),
              const SizedBox(height: 10),
            ],
          ),
        ),
        actions: <Widget>[
          ButtonOne(
              title: 'Suivant!  ',
              onButtonPressed: () async {
                Episode.saveLastUnlockedEpisode(season.id, episode.id);
                if (
                    FirebaseAuth.instance.currentUser != null) {
                  Episode.saveLastUnlockedEpisodeOnFirebase(
                      season.id, episode.id);
                }

                Episode.getLastUnlockedEpisode(season.id).then(
                  (value) async {
                    if (value == season.episodes.length) {
                      if (lenght != season.id) {
                        Season.saveLastUnlockedSeason(season.id + 1);
                        if (FirebaseAuth.instance.currentUser != null) {
                          Season.saveLastUnlockedSeasonOnFirebase();
                        }

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

void popUp(BuildContext context, String message, String title,
    String buttonText, IconData icon, void Function() onButtonPressed) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        icon: Icon(
          icon,
          size: 50,
          color: globalColor,
        ),
        title: Text(title),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
        actions: <Widget>[
          ButtonOne(onButtonPressed: onButtonPressed, title: buttonText)
        ],
      );
    },
  );
}

void popUpHint(
  BuildContext context,
  Season season,
  Episode episode,
  String hint,
  String title,
  String buttonText,
  IconData icon,
  PlayerModel player,
  bool paid,
  Function(bool) onShowChange,
  void Function() onButtonPressed,
) {
  bool show = false;

  bool load = true;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return AlertDialog(
          icon: Icon(
            icon,
            size: 50,
            color: globalColor,
          ),
          title: Text(title),
          content: TextButton(
              onPressed: () async {
                print(paid);
                if (paid) {
                  setState(() {
                    show = true;
                  });
                } else {
                  if (player.coins != 0) {
                    await GameModel.unlockHint(season.id, episode.id);

                    if (FirebaseAuth.instance.currentUser != null) {
                      GameModel.saveHintsToFirebase(season.id);
                    }

                    await PlayerModel.decrementCoins();
                    setState(() {
                      onShowChange(true);
                      show = true;
                    });
                    print('c\'est fait');
                  } else {
                    setState(() {
                      load = false;
                    });
                  }
                }
              },
              child: show
                  ? FutureBuilder(
                      future: Future.delayed(const Duration(seconds: 2)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return LinearProgressIndicator(
                            color: globalColor,
                          );
                        } else {
                          return Text(hint);
                        }
                      },
                    )
                  : load
                      ? const Text('*******')
                      : const Text('Votre solde est insuffisant')),
          actions: <Widget>[
            Row(
              children: [
                Icon(
                  Icons.payment,
                  color: globalColor,
                ),
                Text(
                  "Solde : ${player.coins}",
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
            const Center(
              child: Text(
                'Vous serez facturé pour l\'aide',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonOne(onButtonPressed: onButtonPressed, title: buttonText)
          ],
        );
      });
    },
  );
}

void showSeasonUnlock(BuildContext context, String message, String title) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        icon: Icon(
          Icons.lock_open,
          size: 50,
          color: globalColor,
        ),
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          ButtonOne(
              onButtonPressed: () {
                refreshGlobalColor();
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

void progress(
  BuildContext context,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                backgroundColor: globalColor,
              ),
              const Text(" Chargement..."),
            ],
          ),
        ),
      );
    },
  );
}
