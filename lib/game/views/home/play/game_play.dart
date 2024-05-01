import 'dart:async';

import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/game/components/gameplay_component.dart';
import 'package:africrypt/main.dart';
import 'package:africrypt/models/episodes_model.dart';
import 'package:africrypt/models/game_model.dart';
import 'package:africrypt/models/season_model.dart';
import 'package:flutter/material.dart';
import 'package:africrypt/Models/player_model.dart';

import '../../../components/alert_component.dart';

class GamePlay extends StatefulWidget {
  const GamePlay(
      {super.key,
      required this.game,
      required this.randletters,
      required this.season,
      required this.episode,
      required this.lenght});

  final Season season;
  final GameModel game;
  final Episode episode;
  final List<String> randletters;
  final int lenght;

  @override
  State<GamePlay> createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay>
    with SingleTickerProviderStateMixin {
  bool money = false;
  List<String> selectedWords = [];
  List<int> selectedIndices = [];
  AnimationController? _controller;
  Animation<double>? _animation;
  PlayerModel? player;
  bool show = false;
  late StreamController<bool> _streamController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animation = Tween<double>(begin: 5, end: 50).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.elasticIn,
    ));
    PlayerModel.loadFromSharedPreferences().then((loadedPlayer) {
      setState(() {
        player = loadedPlayer;
      });
    });
    _streamController = StreamController<bool>();
    _checkHintUnlocked();
  }

  Future<void> _checkHintUnlocked() async {
    bool hintUnlocked =
        await GameModel.isHintUnlocked(widget.season.id, widget.episode.id);
    _streamController.add(hintUnlocked);
    setState(() {
      show = hintUnlocked;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeigh = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.game.title),
        actions: [
          IconButton(
              tooltip: 'Aide',
              onPressed: () {
                popUpHint(
                  context,
                  widget.season,
                  widget.episode,
                  widget.game.hint,
                  'Indice',
                  'Go..',
                  Icons.help_center,
                  player!,
                  show,
                  (bool newvalue) {
                    show = newvalue;
                  },
                  () {
                    Navigator.pop(context);
                  },
                );
              },
              icon: Icon(
                Icons.help_rounded,
                color: globalColor,
              ))
        ],
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
                        image: AssetImage(
                            'assets/saisons/saison_${widget.season.id}/enigme_${widget.episode.id}.png'),
                        // Replace with your image
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
            child: AnimatedBuilder(
              animation: _animation!,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_animation!.value, 0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: selectedWords.map((letter) {
                      int originalIdx =
                          selectedIndices[selectedWords.indexOf(letter)];

                      return SelectedGame(
                          letter: letter,
                          onTap: () {
                            selectedWords.remove(letter);
                            selectedIndices.remove(originalIdx);
                            setState(() {});
                          });
                    }).toList(),
                  ),
                );
              },
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
                  onButtonPressed: () async {
                    if (selectedWords.join() == widget.game.words.join()) {
                      setState(() {
                        showSuccessDialog(context, 'Felicitation',
                            widget.season, widget.episode, widget.lenght);
                      });
                    } else {
                      _controller?.reset();
                      _controller?.forward();
                      await Future.delayed(const Duration(milliseconds: 1000));
                      setState(() {
                        selectedWords = [];
                        selectedIndices = [];
                      });
                    }
                  }))
        ],
      ),
    );
  }
}
