import 'dart:async';
import 'package:africrypt/Models/notification_model.dart';
import 'package:africrypt/core/theme.dart';
import 'package:africrypt/models/season_model.dart';
import 'package:africrypt/splash_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'core/firebase_options.dart';

StreamController<Color> colorStreamController = StreamController<Color>();
Color globalColor = GameTheme.colors[0];

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GameTheme.refreshGlobalColor();
  Season.getLastUnlockedSeason().then((value) {
    globalColor = GameTheme.colors[value - 1];
  });

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings.persistenceEnabled;

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: []);

  runApp(const Game());
}

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> with WidgetsBindingObserver {
  AudioPlayer audioPlayer = AudioPlayer();


  @override
  void initState() {
    super.initState();

   NotificationModel.initNotify();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      audioPlayer.pause();
    } else if (state == AppLifecycleState.resumed) {
      audioPlayer.resume();
    }
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