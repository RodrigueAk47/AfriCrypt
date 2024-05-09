import 'package:africrypt/features/letters_treatment_feature.dart';
import 'package:africrypt/features/string_feature.dart';
import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/game/views/home/play/game_play.dart';
import 'package:africrypt/models/episodes_model.dart';
import 'package:africrypt/models/season_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class StoryPlay extends StatelessWidget {
  const StoryPlay(
      {super.key,
      required this.episode,
      required this.season,
      required this.lenght});

  final Season season;
  final Episode episode;
  final int lenght;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/saisons/saison_2/bg.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Expanded(
              // Expanded ensures PDF viewer takes up remaining vertical space
              child: Padding(
                padding: screenWidth > 800
                    ? const EdgeInsets.only(
                        left: 250,
                        right: 250,
                        top: 25,
                        bottom: 20,
                      )
                    : const EdgeInsets.all(0),
                child: SfPdfViewer.asset(
                    'assets/saisons/saison_${season.id}/story_${episode.id}.pdf'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: responsive<double>(context, 200, 5),
                  right: responsive<double>(context, 200, 5),
                  top: responsive<double>(context, 10, 5),
                  bottom: responsive<double>(context, 10, 5)),
              child: ButtonOne(
                  title: 'Jouer',
                  onButtonPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GamePlay(
                                  lenght: lenght,
                                  episode: episode,
                                  season: season,
                                  game: episode.stories.game,
                                  randletters: randomizewords(List.from(
                                    episode.stories.game.words,
                                  )),
                                )));
                  }),
            ), // Button added here
          ],
        ),
      ),
    );
  }
}
