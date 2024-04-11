import 'package:africrypt/Models/episodes_model.dart';
import 'package:africrypt/game/views/home/play/story_play.dart';
import 'package:flutter/material.dart';

import '../../core/theme.dart';
import 'button_component.dart';

class HomeCard extends StatelessWidget {
  const HomeCard(
      {super.key,
      required this.img,
      required this.numSeason,
      required this.title,
      required this.onPressCard});
  final String img;
  final int numSeason;
  final String title;
  final void Function() onPressCard;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressCard,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.asset(
                    img,
                    fit: BoxFit.cover,
                    width: 360,
                  )),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      'Saison $numSeason : ',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SeasonCard extends StatelessWidget {
  const SeasonCard(
      {super.key,
      required this.id,
      required this.title,
      required this.description, required this.episode,});

  final int id;
  final String title;
  final String description;
  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(19),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.play_arrow,
                    color: GameTheme.mainColor,
                    size: 45,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Episode $id',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black54)),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(description),
              const SizedBox(
                height: 10,
              ),
              ButtonOne(onButtonPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StoryPlay(
                              episode: episode,
                            )));
              })
            ],
          ),
        ),
      ),
    );
  }
}
