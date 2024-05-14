import 'package:africrypt/features/letters_treatment_feature.dart';
import 'package:africrypt/features/string_feature.dart';
import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/game/views/home/play/game_play.dart';
import 'package:africrypt/models/episodes_model.dart';
import 'package:africrypt/models/season_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class StoryPlay extends StatefulWidget {
  const StoryPlay(
      {super.key,
      required this.episode,
      required this.season,
      required this.lenght});

  final Season season;
  final Episode episode;
  final int lenght;

  @override
  State<StoryPlay> createState() => _StoryPlayState();
}

class _StoryPlayState extends State<StoryPlay> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/saisons/saison_${widget.season.id}/bg.jpg'),
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
                    'assets/saisons/saison_${widget.season.id}/story_${widget.episode.id}.pdf'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: responsive<double>(context, 200, 5),
                  right: responsive<double>(context, 200, 5),
                  top: responsive<double>(context, 10, 5),
                  bottom: responsive<double>(context, 10, 5)),
              child: ButtonOne(
                  loading: loading,
                  title: 'Jouer',
                  onButtonPressed: () {
                    setState(() {
                      loading = true;
                    });
                    Future.delayed(const Duration(seconds: 4), () {
                      setState(() {
                        loading = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GamePlay(
                                    lenght: widget.lenght,
                                    episode: widget.episode,
                                    season: widget.season,
                                    game: widget.episode.stories.game,
                                    randletters: randomizewords(List.from(
                                      widget.episode.stories.game.words,
                                    )),
                                  )));
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
