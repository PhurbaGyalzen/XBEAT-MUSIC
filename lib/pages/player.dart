import "package:flutter/material.dart";
import "package:audioplayers/audioplayers.dart";

class AudioScreen extends StatefulWidget {
  const AudioScreen({Key? key}) : super(key: key);

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  AudioPlayer audioPlayer = AudioPlayer();

  // only change the link inside play()
  initAudio() {
    audioPlayer.play(
      "http://172.25.0.130:3000/stream/song/Real Friends - CAMILA CABELLO ft SWAE LEE.mp3",
    );
  }

  pauseAudio() {
    audioPlayer.pause();
  }

  stopAudio() {
    audioPlayer.stop();
  }

  Widget getBody() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: initAudio,
          child: Text("Play"),
          style: ElevatedButton.styleFrom(
              primary: Colors.amber,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        ElevatedButton(
          onPressed: pauseAudio,
          child: Text("Pause"),
          style: ElevatedButton.styleFrom(
              primary: Colors.purple,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        ElevatedButton(
          onPressed: stopAudio,
          child: Text("Stop"),
          style: ElevatedButton.styleFrom(
              primary: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        Image.network(
          "http://172.25.0.130:3000/images/test.png",
          height: 200,
          width: 200,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Newtwork Audio Screen"),
          centerTitle: true,
        ),
        body: getBody());
  }
}
