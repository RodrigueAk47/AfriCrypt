import 'dart:async';
import 'package:africrypt/core/theme.dart';
import 'package:africrypt/models/episodes_model.dart';
import 'package:africrypt/models/season_model.dart';
import 'package:africrypt/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/firebase_options.dart';

StreamController<Color> colorStreamController = StreamController<Color>();
Color globalColor = GameTheme.colors[0];

void refreshGlobalColor() async {
  int lastUnlockedSeason = await Season.getLastUnlockedSeason();
  globalColor = GameTheme.colors[lastUnlockedSeason - 1];
  colorStreamController.add(globalColor);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  refreshGlobalColor();
  Season.getLastUnlockedSeason().then((value) {
    globalColor = GameTheme.colors[value - 1];
  });

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  int? lastUnlockedSeason = prefs.getInt('last_unlocked_season');
  if (lastUnlockedSeason == null) {
    await Season.saveLastUnlockedSeason(1);
    lastUnlockedSeason = 1;
  }

  String? lastUnlockedEpisode =
      prefs.getString('last_unlocked_episode_$lastUnlockedSeason');
  if (lastUnlockedEpisode == null) {
    await Episode.saveLastUnlockedEpisode(lastUnlockedSeason, 0);
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: []);

  runApp(const Game());
}

class Game extends StatefulWidget {
  //final Database database;

  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  // initial la page de connexion

  @override
  void initState() {
    super.initState();

    // Vérifier la table et rediriger au lancement
    /*WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Démarrer le son après le premier rendu
      AudioPlayer audioPlayer = AudioPlayer();
      audioPlayer.setReleaseMode(ReleaseMode.loop);
      await audioPlayer.play(AssetSource('music/theme.mp3'));
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Color>(
        stream: colorStreamController.stream,
        initialData: globalColor,
        builder: (context, snapshot) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'AfriCrypt',
            home: SplashScreen(),
          );
        });
  }
}
