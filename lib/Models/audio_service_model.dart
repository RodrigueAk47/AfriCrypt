import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:africrypt/models/season_model.dart';

class AudioServiceModel {
  final AudioPlayer _audioPlayer = AudioPlayer();

  int _currentAudioSource = 0;

  final AudioSource = <String>[
    'music/theme.mp3',
    'music/success.mp3',
  ];

  void updateCurrentAudioSource() async {
    _currentAudioSource = await Season.getLastUnlockedSeason();
  }

  Future<void> init() async {
    updateCurrentAudioSource();
    await _audioPlayer.setVolume(0.09);
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource(AudioSource[0]));
  }

  Future<void> playSuccessSound() async {
    await _audioPlayer.play(AssetSource(AudioSource[1]));
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _audioPlayer.pause();
    } else if (state == AppLifecycleState.resumed) {
      _audioPlayer.resume();
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
