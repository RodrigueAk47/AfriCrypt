import 'package:africrypt/core/theme.dart';
import 'package:africrypt/game/components/card_component.dart';
import 'package:flutter/material.dart';

class SeasonPlay extends StatefulWidget {
  const SeasonPlay({super.key});

  @override
  State<SeasonPlay> createState() => _SeasonPlayState();
}

class _SeasonPlayState extends State<SeasonPlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saison 1',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: GameTheme.mainColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.only(top: 35, left: 35, right: 35),
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'Prologue en Afrique Oriental Bref ',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  textAlign: TextAlign.center,
                  '1 completé sur 5 ',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          SeasonCard(),
          SeasonCard(),
          SeasonCard(),
          SeasonCard(),
        ],
      ),
    );
  }
}
