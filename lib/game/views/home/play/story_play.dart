import 'package:africrypt/Models/episodes_model.dart';
import 'package:africrypt/features/letters_treatment_feature.dart';
import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/game/views/home/play/game_play.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class StoryPlay extends StatelessWidget {
  const StoryPlay({super.key, required this.episode});
  final Episode episode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(episode.title),
      ),
      body: Column(
        children: [
          Expanded(
            // Expanded ensures PDF viewer takes up remaining vertical space
            child: SfPdfViewer.asset(episode.stories.pdf),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ButtonOne(onButtonPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GamePlay(
                            game: episode.stories.game,
                            randletters: randomizewords(List.from(
                              episode.stories.game.words,
                            )),
                          )));
            }),
          ), // Button added here
        ],
      ),
    );
  }
}
