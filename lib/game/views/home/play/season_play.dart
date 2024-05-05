
import 'package:africrypt/game/components/card_component.dart';
import 'package:africrypt/game/views/dashboard_view.dart';
import 'package:africrypt/main.dart';
import 'package:africrypt/models/episodes_model.dart';
import 'package:africrypt/models/season_model.dart';
import 'package:flutter/material.dart';

class SeasonPlay extends StatefulWidget {
  final Season season;
  final int lenght;

  const SeasonPlay({super.key, required this.season, required this.lenght});

  @override
  State<SeasonPlay> createState() => _SeasonPlayState();
}

class _SeasonPlayState extends State<SeasonPlay> {
  int? lastUnlockedEpisodeNumber;

  @override
  void initState() {
    super.initState();

    Episode.getLastUnlockedEpisode(widget.season.id).then((id) {
      setState(() {
        lastUnlockedEpisodeNumber = id;
      });
    });
  }

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
        backgroundColor: globalColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/saisons/saison_${widget.season.id}/saison.png'), fit: BoxFit.cover)
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 35, left: 35, right: 35),
              child: Column(
                children: [
                  Container(

                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(16),
                      border: Border(
                          left: BorderSide(width: 5, color: globalColor),
                          bottom: BorderSide(width: 5, color: globalColor),),

                    ),
                    child: Container(

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(9),

                      child: Text(
                        textAlign: TextAlign.center,
                        widget.season.description,
                        style:  TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold, color: globalColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    lastUnlockedEpisodeNumber == null
                        ? 'Loading...'
                        : '$lastUnlockedEpisodeNumber completé sur ${widget.season.episodes.length}',
                    textAlign: TextAlign.center,
                    style:  const TextStyle(fontSize: 17, color: Colors.black, backgroundColor: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.season.episodes.length,
                itemBuilder: (context, index) {
                  final episode = widget.season.episodes[index];
                  return FutureBuilder<bool>(
                    future: Episode.isEpisodeUnlocked(
                        widget.season.id, widget.season.episodes[index].id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // Show a loading spinner while waiting
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error: ${snapshot.error}'); // Show an error message if something went wrong
                      } else if (snapshot.hasData) {
                        bool isUnlocked = snapshot.data ?? false;
                        return SeasonCard(
                          length: widget.lenght,
                          episode: episode,
                          id: episode.id,
                          title: episode.title,
                          description: episode.description,
                          season: widget.season,
                          enabled: isUnlocked,
                        );
                      } else {
                        return const SizedBox
                            .shrink(); // Return an empty widget if no data
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
