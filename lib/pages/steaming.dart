import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'page_manager.dart';
import 'package:flutter/material.dart';

class StreamApp extends StatefulWidget {
  const StreamApp({Key? key}) : super(key: key);

  @override
  _StreamAppState createState() => _StreamAppState();
}

class _StreamAppState extends State<StreamApp> {
  late final PageManager _pageManager;

  @override
  void initState() {
    super.initState();

    _pageManager = PageManager();
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Spacer(),
            ValueListenableBuilder<ProgressBarState>(
              valueListenable: _pageManager.progressNotifier,
              builder: (_, value, __) {
                return ProgressBar(
                  progress: value.current,
                  buffered: value.buffered,
                  total: value.total,
                  onSeek: _pageManager.seek,
                  timeLabelTextStyle: TextStyle(color: Colors.white),
                  timeLabelLocation: TimeLabelLocation.below,
                  timeLabelPadding: 5,
                );
              },
            ),
            ValueListenableBuilder<ButtonState>(
              valueListenable: _pageManager.buttonNotifier,
              builder: (_, value, __) {
                switch (value) {
                  case ButtonState.loading:
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      width: 32.0,
                      color: Colors.black,
                      height: 32.0,
                      child: const CircularProgressIndicator(),
                    );
                  case ButtonState.paused:
                    return IconButton(
                      icon: const Icon(Icons.play_arrow),
                      iconSize: 32.0,
                      color: Colors.white,
                      onPressed: _pageManager.play,
                    );
                  case ButtonState.playing:
                    return IconButton(
                      icon: const Icon(Icons.pause),
                      iconSize: 32.0,
                      color: Colors.white,
                      onPressed: _pageManager.pause,
                    );
                }
              },
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
