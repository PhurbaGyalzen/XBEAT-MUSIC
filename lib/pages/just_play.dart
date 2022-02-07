import "package:flutter/material.dart";
import "package:just_audio/just_audio.dart";

class MyPlayer extends StatefulWidget {
  const MyPlayer({Key? key}) : super(key: key);

  @override
  _MyPlayerState createState() => _MyPlayerState();
}

class _MyPlayerState extends State<MyPlayer> {
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                await player.setUrl(
                    "http://192.168.1.17:3000/stream/song/Real Friends - CAMILA CABELLO ft SWAE LEE.mp3");
                player.play();
              },
              child: Text("Music"),
            ),
            SizedBox(
              width: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  player.pause();
                },
                child: Text("Pause")),
            SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: () {
                player.stop();
              },
              child: Text("Stop"),
            ),
          ],
        ),
      ),
    );
  }
}
