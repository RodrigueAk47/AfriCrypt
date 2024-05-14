import 'dart:math';

List<String> randomizewords(List<String> letters) {
  var rng = Random();
  List<String> randletters = letters; // Your JSON letters

  if (randletters.isNotEmpty &&
      randletters[0].isNotEmpty &&
      RegExp(r'^\d+$').hasMatch(randletters[0])) {
    while (randletters.length < 20) {
      randletters.add(rng
          .nextInt(10)
          .toString()); // Convertit le nombre aléatoire en une chaîne de caractères
    }
  } else {
    while (randletters.length < 20) {
      randletters.add(String.fromCharCode(rng.nextInt(26) + 'A'.codeUnitAt(0)));
    }
  }
  randletters.shuffle();
  return randletters;
}
