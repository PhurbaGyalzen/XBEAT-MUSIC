import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:xbeat/notifiers/play_button_notifier.dart';
import 'package:xbeat/notifiers/progress_notifier.dart';
import 'package:xbeat/pages/page_manager.dart';
import 'package:xbeat/pages/steaming.dart';
import 'package:xbeat/services/service_locator.dart';
import 'package:xbeat/theme/colors.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test")),
      body: Center(
          child: Column(children: [
        ElevatedButton(
          onPressed: () {
            getIt<PageManager>().loadNewPlaylist();
          },
          child: Text(" Play New Playlist"),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: MiniPlayer(),
          ),
        ),
      ])),
    );
  }
}

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        tileColor: black,
        dense: true,
        leading: Image.asset("assets/login.png"),
        title: Text(
          "Playing",
          style: TextStyle(fontSize: 15, color: white),
        ),
        onTap: () {
          Get.to(StreamApp());
        },
        subtitle: Text(
          "Song description",
          style: TextStyle(color: white, fontSize: 10),
        ),
        trailing: PlayButton(),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: AudioProgressBar(),
      ),
    ]);
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<ButtonState>(
      valueListenable: pageManager.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: EdgeInsets.all(10.0),
              width: 25.0,
              height: 25.0,
              child: CircularProgressIndicator(
                color: white,
              ),
            );
          case ButtonState.paused:
            return FloatingActionButton(
              heroTag: "spausebutton",
              child: Icon(Icons.play_arrow_rounded, color: primary, size: 40),
              onPressed: pageManager.play,
              foregroundColor: Colors.black,
              backgroundColor: black,
            );
          case ButtonState.playing:
            return FloatingActionButton(
              heroTag: "splaybutton",
              child: Icon(
                Icons.pause_rounded,
                color: primary,
                size: 40,
              ),
              onPressed: pageManager.pause,
              foregroundColor: Colors.black,
              backgroundColor: black,
            );
        }
      },
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          thumbRadius: 0,
          total: value.total,
          progressBarColor: primary,
          timeLabelLocation: TimeLabelLocation.none,
          timeLabelTextStyle: TextStyle(color: Colors.grey[400]),
          barHeight: 1.0,
        );
      },
    );
  }
}
