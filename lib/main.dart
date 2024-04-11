
import 'package:africrypt/game/views/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game/views/dashboard_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //final database = await User.open();
  runApp(const Game(/*database: database*/));
}

class Game extends StatefulWidget {
  //final Database database;

  const Game({super.key, /*required this.database*/});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  Widget _homePage = const LoginView(); // Initialement la page de connexion

  /*Future<void> checkTableAndRedirect() async {
    final results = await widget.database.query('user');

    if (results.isNotEmpty) {
      setState(() {
        _homePage = const Dashboard();
      });
    }
  }
  */

  @override
  void initState() {
    super.initState();

   // checkTableAndRedirect(); // Vérifier la table et rediriger au lancement
    /*WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Démarrer le son après le premier rendu
      AudioPlayer audioPlayer = AudioPlayer();
      audioPlayer.setReleaseMode(ReleaseMode.loop);
      await audioPlayer.play(AssetSource('music/theme.mp3'));
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AfriCrypt',
      home: Dashboard(),
    );
  }
}
