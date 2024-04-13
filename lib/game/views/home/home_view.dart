import 'package:africrypt/Models/season_model.dart';
import 'package:africrypt/core/theme.dart';
import 'package:africrypt/game/components/card_component.dart';
import 'package:africrypt/game/views/home/play/season_play.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Future<Map<String, dynamic>?> user = User.getFirstUser();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg3.jpg'), fit: BoxFit.cover)),
      child: Stack(children: [
        Positioned(
          top: 10,
          right: 0,
          left: 0,
          child: Container(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 120),
          child: ListView(
            children: [
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.video_camera_back,
                            color: GameTheme.mainColor,
                            size: 55.0,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            children: [
                              Text(
                                'Saison',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                '1',
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w900),
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
                      const Row(
                        children: [
                          Icon(
                            Icons.paid,
                            color: Colors.amber,
                            size: 55.0,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            children: [
                              Text(
                                'Coins',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                '2',
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w900),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(19.0),
                child: Text('Saisons',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: GameTheme.mainColor)),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder(
                  future: Season.loadSaisonsFromAssets(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final seasons = snapshot.data as List<Season>;
                      return Row(
                        children: seasons
                            .map((season) => HomeCard(
                                img:
                                    "assets/images/data/saison${season.id}.png",
                                numSeason: season.id,
                                title: season.title,
                                onPressCard: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SeasonPlay(
                                                season: season,
                                              )));
                                }))
                            .toList(),
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
