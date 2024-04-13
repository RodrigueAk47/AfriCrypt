import 'package:africrypt/Models/game_model.dart';
import 'package:africrypt/Models/season_model.dart';
import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/game/components/gameplay_component.dart';
import 'package:flutter/material.dart';
import '../../../components/alert_component.dart';

class GamePlay extends StatefulWidget {
  const GamePlay(
      {super.key,
      required this.game,
      required this.randletters,
      required this.season});
  final Season season;
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
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeigh = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.game.title),
      ),
      body: ListView(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Card(
                margin: screenWidth > 600
                    ? EdgeInsets.only(
                        left: screenWidth * 0.3,
                        right: screenWidth * 0.3,
                        bottom: 25)
                    : const EdgeInsets.only(
                        left: 20, right: 20, top: 5, bottom: 10),
                elevation: 5,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(widget.game.enigme,
                          style: const TextStyle(fontSize: 15)),
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      child: Image(
                        image: const AssetImage(
                            'assets/images/saison1.png'), // Replace with your image
                        width: constraints.maxWidth,
                        height: screenWidth > 600
                            ? screenHeigh * 0.5
                            : null, // This will make the image take the full width of the Card
                      ),
                    ),
                    // Rest of your children here
                  ],
                ),
              );
            },
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 10,
            ),
            height: 55,
            color: Colors.black26,
            child: Center(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: selectedWords
                    .map((letter) => SelectedGame(letter: letter))
                    .toList(),
              ),
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
                  
                },
              );
            }).toList(),
          ),
          Container(
              margin: const EdgeInsets.only(top: 25, bottom: 25),
              child: ButtonOne(
                title: 'Valider',
                onButtonPressed: () {
                if (selectedWords.join() == widget.game.words.join()) {
                  setState(() {
                    showSuccessDialog(context, 'Felicitation', widget.season);
                  });
                }
                
              }))
        ],
      ),
    );
  }
}
