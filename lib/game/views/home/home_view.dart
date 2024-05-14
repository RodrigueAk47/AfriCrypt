import 'dart:async';

import 'package:africrypt/game/components/alert_component.dart';
import 'package:africrypt/game/components/card_component.dart';
import 'package:africrypt/game/views/home/play/season_play.dart';
import 'package:africrypt/main.dart';
import 'package:africrypt/models/player_model.dart';
import 'package:africrypt/models/season_model.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _controller;
  late Timer _timer;
  int stopPage = 1;
  int lastUnlockedSeasonNumber = 1;

  @override
  void initState() {
    super.initState();
    Season.getLastUnlockedSeason().then((id) {
      setState(() {
        lastUnlockedSeasonNumber = id;
        stopPage = id;
      });
    });

    _controller = PageController(initialPage: 0, viewportFraction: 1);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_controller.hasClients) {
        if (_controller.page!.round() == _controller.page) {
          if (_controller.page! < _controller.position.maxScrollExtent &&
              _controller.page! < stopPage - 1) {
            _controller.nextPage(
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
            );
          } else {
            _timer.cancel();
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'assets/saisons/saison_$lastUnlockedSeasonNumber/saison.jpg'),
              fit: BoxFit.cover)),
      child: Stack(children: [
        Positioned(
          top: 10,
          right: 0,
          left: 0,
          child: Container(
            margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
            child: FutureBuilder(
              future: PlayerModel.loadFromSharedPreferences(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  PlayerModel player = snapshot.data!;
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          Text(
                            'Hey ${player.name}',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: globalColor),
                          ),
                          Text(
                            'Let\'s Play',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 29,
                                color: globalColor),
                          ),
                        ]),
                        GestureDetector(
                          onTap: () => Season.saveLastUnlockedSeason(2),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Image.asset(
                              'assets/images/perso/${player.gender == false ? 'boy' : 'girl'}.png',
                              scale: 9,
                            ),
                          ),
                        ),
                      ]);
                } else if (snapshot.hasError) {
                  return Text("Erreur : ${snapshot.error}");
                }
                return const Text('Hey');
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 120,
          ),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border(
                      left: BorderSide(width: 5, color: globalColor),
                      right: BorderSide(width: 5, color: globalColor)),
                ),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: FutureBuilder(
                      future: PlayerModel.loadFromSharedPreferences(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          PlayerModel player = snapshot.data!;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.video_camera_back,
                                    color: globalColor,
                                    size: 55.0,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Saison',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        lastUnlockedSeasonNumber.toString(),
                                        style: const TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                color: Colors.grey,
                                child: const VerticalDivider(
                                  width: 2,
                                  endIndent: 60,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.paid,
                                    color: globalColor,
                                    size: 55.0,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Coins',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        player.coins.toString(),
                                        style: const TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text("Erreur : ${snapshot.error}");
                        }
                        return const Text('Hey');
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(19.0),
                child: Text('Saisons',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: globalColor)),
              ),
              FutureBuilder(
                future: Season.loadSaisonsFromAssets(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final seasons = snapshot.data as List<Season>;

                    return SizedBox(
                      height: 309,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: _controller,
                          itemCount: seasons.length,
                          itemBuilder: (context, index) {
                            Season season = seasons[index];

                            return FutureBuilder<bool>(
                              future: Season.isSeasonUnlocked(season.id),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator(); // Show a loading spinner while waiting
                                } else if (snapshot.hasError) {
                                  return Text(
                                      'Error: ${snapshot.error}'); // Show an error message if something went wrong
                                } else if (snapshot.hasData) {
                                  bool isUnlocked = snapshot.data ?? false;
                                  return HomeCard(
                                      enabled: isUnlocked,
                                      img:
                                          "assets/saisons/saison_${season.id}/saison_${season.id}.jpg",
                                      numSeason: season.id,
                                      title: season.title,
                                      onPressCard: () {
                                        isUnlocked
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SeasonPlay(
                                                            lenght:
                                                                seasons.length,
                                                            season: season)))
                                            : popUp(
                                                context,
                                                'Veuillez terminer la saison precedente',
                                                'Verrouillé',
                                                'OK',
                                                Icons.lock, () {
                                                Navigator.pop(context);
                                              });
                                      });
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            );
                          }),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      ]),
    );
  }
}
