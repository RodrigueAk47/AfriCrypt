import 'package:africrypt/Models/season_model.dart';
import 'package:africrypt/core/theme.dart';
import 'package:africrypt/game/components/card_component.dart';
import 'package:africrypt/game/views/dashboard_view.dart';
import 'package:flutter/material.dart';

class SeasonPlay extends StatefulWidget {
  final Season season;
  const SeasonPlay({super.key, required this.season});

  @override
  State<SeasonPlay> createState() => _SeasonPlayState();
}

class _SeasonPlayState extends State<SeasonPlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Custom behavior here
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const Dashboard())); // This will navigate back to the previous route
          },
        ),
        title: Text(
          widget.season.title,
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
                  widget.season.description,
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  textAlign: TextAlign.center,
                  '1 completé sur ${widget.season.episodes.length} ',
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.season.episodes.length,
              itemBuilder: (context, index) {
                final episode = widget.season.episodes[index];
                return SeasonCard(
                  id: episode.id,
                  title: episode.title,
                  description: episode.description,
                  season: widget.season,
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
