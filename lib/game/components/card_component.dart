import 'package:africrypt/game/components/alert_component.dart';
import 'package:africrypt/game/views/home/play/story_play.dart';
import 'package:africrypt/main.dart';
import 'package:africrypt/models/episodes_model.dart';
import 'package:africrypt/models/season_model.dart';
import 'package:flutter/material.dart';

import 'button_component.dart';

class HomeCard extends StatelessWidget {
  const HomeCard(
      {super.key,
      required this.img,
      required this.numSeason,
      required this.title,
      required this.onPressCard,
      required this.enabled});

  final String img;
  final int numSeason;
  final String title;
  final bool enabled;
  final void Function() onPressCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressCard,
      child: Container(
        margin: const EdgeInsets.only(left: 13, right: 13),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border(
                left: BorderSide(width: 5, color: globalColor),
                bottom: BorderSide(width: 5, color: globalColor))),
        width: 380,
        child: Card(
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Image.asset(
                      img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(enabled ? Icons.lock_open : Icons.lock,
                        color: globalColor),
                    Text(
                      ' Saison $numSeason: ',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
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
  const SeasonCard({
    super.key,
    required this.id,
    required this.title,
    required this.season,
    required this.episode,
    this.enabled = false,
    required this.length,
    this.isCompleted = false,
  });

  final int id;
  final String title;
  final Season season;
  final Episode episode;
  final bool enabled;
  final int length;
  final bool loading = false;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 4,
      margin: screenWidth > 600
          ? EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              top: 25,
              bottom: 20)
          : const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
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
                  Icon(
                    enabled ? isCompleted ? Icons.check :Icons.play_arrow : Icons.lock,
                    color: globalColor,
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
              const SizedBox(
                height: 10,
              ),
              ButtonOne(
                  enabled: enabled,
                  title: 'Go..',
                  onButtonPressed: () {
                    enabled
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StoryPlay(
                                      lenght: length,
                                      season: season,
                                      episode: episode,
                                    )))
                        : popUp(
                            context,
                            'Veuillez terminer l\'episode precedente',
                            'Verrouillé',
                            'Ok',
                            Icons.lock, () {
                            Navigator.pop(context);
                          });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
