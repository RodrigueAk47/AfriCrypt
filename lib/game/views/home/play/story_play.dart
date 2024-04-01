import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/game/views/home/play/game_play.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class StoryPlay extends StatelessWidget {
  const StoryPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Story'),
      ),
      body: Column(
        children: [
          Expanded(
            // Expanded ensures PDF viewer takes up remaining vertical space
            child: SfPdfViewer.asset('assets/pdf/pdftest.pdf'),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ButtonOne(onButtonPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const GamePlay()));
            }),
          ), // Button added here
        ],
      ),
    );
  }
}
