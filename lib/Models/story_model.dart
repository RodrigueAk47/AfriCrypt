import 'package:africrypt/models/game_model.dart';

class Story {
  final GameModel game;

  Story({required this.game});

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      game: GameModel.fromJson(json['jeu']),
    );
  }
}
