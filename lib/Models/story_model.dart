import 'package:africrypt/Models/game_model.dart';

class Story {
  final String pdf;
  final GameModel game;

  Story({required this.pdf, required this.game});

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      pdf: json['pdf'],
      game: GameModel.fromJson(json['jeu']),
    );
  }
}
