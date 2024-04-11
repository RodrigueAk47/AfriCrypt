import 'package:africrypt/Models/story_model.dart';

class Episode {
  final int id;
  final String title;
  final String description;
  final Story stories;

  Episode(
      {required this.id,
      required this.title,
      required this.description,
      required this.stories});

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['numero'],
      title: json['titre'],
      description: json['description'],
      stories: Story.fromJson(json['stories']),
    );
  }
}
