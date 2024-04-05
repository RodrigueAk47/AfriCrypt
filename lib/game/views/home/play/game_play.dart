import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/game/components/gameplay_component.dart';
import 'package:flutter/material.dart';

class GamePlay extends StatefulWidget {
  const GamePlay({super.key});

  @override
  State<GamePlay> createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play'),
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
                  child: const Text(
                    """Lorem is text idols jkdnkjbk dkldnldk ld,lmd ilhdihdlih dkldnldk ld,lmd,l ilhdihdlih dkldnldk ld,lmd,l ilhdihdlihilhdihdlihs """,
                    style: TextStyle(fontSize: 16),
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
              children: const [
                SelectedGame(letter: 'G'),
                SelectedGame(letter: 'E'),
                SelectedGame(letter: 'N'),
                SelectedGame(letter: 'I'),
                SelectedGame(letter: 'E'),
              ],
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              TextGame(isSelect: true, letter: 'G', onTap: () {}),
              TextGame(isSelect: false, letter: 'L', onTap: () {}),
              TextGame(isSelect: true, letter: 'N', onTap: () {}),
              TextGame(isSelect: true, letter: 'E', onTap: () {}),
              TextGame(isSelect: false, letter: 'G', onTap: () {}),
              TextGame(isSelect: false, letter: 'A', onTap: () {}),
              TextGame(isSelect: false, letter: 'G', onTap: () {}),
              TextGame(isSelect: true, letter: 'E', onTap: () {}),
              TextGame(isSelect: false, letter: 'G', onTap: () {}),
              TextGame(isSelect: false, letter: 'A', onTap: () {}),
              TextGame(isSelect: false, letter: 'G', onTap: () {}),
              TextGame(isSelect: true, letter: 'I', onTap: () {}),
            ],
          ),
          Container(
              margin: const EdgeInsets.only(top: 25, bottom: 25),
              child: ButtonOne(onButtonPressed: () {}))
        ],
      ),
    );
  }
}
