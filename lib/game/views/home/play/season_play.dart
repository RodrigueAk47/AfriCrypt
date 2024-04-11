import 'package:africrypt/Models/season_model.dart';
import 'package:africrypt/core/theme.dart';
import 'package:africrypt/game/components/card_component.dart';
import 'package:flutter/material.dart';

class SeasonPlay extends StatefulWidget {
  final Saison saison;
  const SeasonPlay({super.key, required this.saison});

  @override
  State<SeasonPlay> createState() => _SeasonPlayState();
}

class _SeasonPlayState extends State<SeasonPlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.saison.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: GameTheme.mainColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35, left: 35, right: 35),
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  widget.saison.description,
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  '1 completé sur 5 ',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.saison.episodes.length,
              itemBuilder: (context, index) {
                final episode = widget.saison.episodes[index];
                return SeasonCard(
                  id: episode.id,
                  title: episode.title,
                  description: episode.description,
                  episode: episode,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
