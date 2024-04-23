import 'dart:math';

List<String> randomizewords(List<String> letters) {
  var rng = Random();
  List<String> randletters = letters; // Your JSON letters

  while (randletters.length < 12) {
    randletters.add(String.fromCharCode(rng.nextInt(26) + 'A'.codeUnitAt(0)));
  }

  randletters.shuffle();
  return randletters;
}
