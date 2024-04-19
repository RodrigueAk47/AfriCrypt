import 'package:africrypt/game/views/auth/login_view.dart';
import 'package:africrypt/game/views/auth/signin_view.dart';
import 'package:africrypt/models/episodes_model.dart';
import 'package:africrypt/models/player_model.dart';
import 'package:africrypt/models/season_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game/views/dashboard_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/firebase_options.dart';
import 'package:audioplayers/audioplayers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
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

  runApp(const Game());
}

class Game extends StatefulWidget {
  //final Database database;

  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  Widget _homePage = defaultTargetPlatform == TargetPlatform.windows
      ? const LoginView()
      : const SignIn(); // Initialement la page de connexion

  Future<void> checkTableAndRedirect() async {
    if (await PlayerModel.loadFromSharedPreferences() != null) {
      setState(() {
        _homePage = const Dashboard();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    checkTableAndRedirect(); // Vérifier la table et rediriger au lancement
    /*WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Démarrer le son après le premier rendu
      AudioPlayer audioPlayer = AudioPlayer();
      audioPlayer.setReleaseMode(ReleaseMode.loop);
      await audioPlayer.play(AssetSource('music/theme.mp3'));
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AfriCrypt',
      home: _homePage,
    );
  }
}
