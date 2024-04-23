class GameModel {
  final String title;
  final String enigme;
  final String img;
  final List<String> words;

  GameModel(
      {required this.title,
      required this.enigme,
      required this.img,
      required this.words});

  factory GameModel.fromJson(Map<String, dynamic> json) {
    var motsList = json['mots'] as List;
    List<String> mots = motsList.map((i) => i.toString()).toList();

    return GameModel(
      title: json['titre'],
      enigme: json['enigme'],
      img: json['image'],
      words: mots,
    );
  }
}
