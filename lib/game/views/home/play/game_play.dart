import 'package:africrypt/Models/game_model.dart';
import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/game/components/gameplay_component.dart';
import 'package:africrypt/game/views/home/play/success_play.dart';
import 'package:flutter/material.dart';

class GamePlay extends StatefulWidget {
  const GamePlay({super.key, required this.game, required this.randletters});
  final GameModel game;
  final List<String> randletters;

  @override
  State<GamePlay> createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay> {
  List<String> selectedWords = [];
  List<int> selectedIndices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.game.title),
      ),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            elevation: 5,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 25, bottom: 25),
                  child: Text(
                    widget.game.enigme,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  child: Image.asset(
                    'assets/images/saison1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 25,
              bottom: 25,
            ),
            height: 65,
            color: Colors.black26,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: selectedWords
                  .map((letter) => SelectedGame(letter: letter))
                  .toList(),
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            // Define the variable 'letters'
            children: widget.randletters.asMap().entries.map((entry) {
              int idx = entry.key;
              String word = entry.value;
              return TextGame(
                isSelect: selectedIndices.contains(idx),
                letter: word,
                onTap: () {
                  setState(() {
                    if (selectedIndices.contains(idx)) {
                      selectedIndices.remove(idx);
                      selectedWords.remove(word);
                    } else {
                      selectedIndices.add(idx);
                      selectedWords.add(word);
                    }
                  });
                  print(selectedWords);
                },
              );
            }).toList(),
          ),
          Container(
              margin: const EdgeInsets.only(top: 25, bottom: 25),
              child: ButtonOne(
                onButtonPressed: () {
                  if (selectedWords.join() == widget.game.words.join()) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Success(),
                        ));
                  }
                },
              ))
        ],
      ),
    );
  }
}
