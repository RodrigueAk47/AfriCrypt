import 'dart:async';
import 'package:africrypt/Models/audio_service_model.dart';
import 'package:africrypt/Models/notification_model.dart';
import 'package:africrypt/core/theme.dart';
import 'package:africrypt/splash_screen.dart';
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
  final AudioServiceModel _audioService = AudioServiceModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _audioService.init();
    });
    NotificationModel.initNotify();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _audioService.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _audioService.didChangeAppLifecycleState(state);
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
