class GameModel {
  final String title;
  final String enigme;
  final List<String> words;

  GameModel(
      {required this.title,
      required this.enigme,
      required this.words});

  factory GameModel.fromJson(Map<String, dynamic> json) {
    var motsList = json['mots'] as List;
    List<String> mots = motsList.map((i) => i.toString()).toList();

    return GameModel(
      title: json['titre'],
      enigme: json['enigme'],
      words: mots,
    );
  }
}
