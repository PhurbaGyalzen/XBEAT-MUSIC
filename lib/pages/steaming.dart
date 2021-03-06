// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:get/get.dart';
import 'page_manager.dart';
import 'package:flutter/material.dart';
import 'package:all_sensors/all_sensors.dart';
import '../notifiers/play_button_notifier.dart';
import '../notifiers/progress_notifier.dart';
import '../notifiers/repeat_button_notifier.dart';
import '../theme/colors.dart';
import '../services/service_locator.dart';
import 'package:shake/shake.dart';

class StreamApp extends StatefulWidget {
  const StreamApp({Key? key}) : super(key: key);

  @override
  _StreamAppState createState() => _StreamAppState();
}

class _StreamAppState extends State<StreamApp> {
  late ShakeDetector detector;
  bool proximityValues = false;
  @override
  void initState() {
    super.initState();
    getIt<PageManager>().init();
    proximityEvents.listen((ProximityEvent event) {
      setState(() {
        // event.getValue return true or false
        proximityValues = event.getValue();
      });
    });
    detector = ShakeDetector.waitForStart(onPhoneShake: () {
      // Do stuff on phone shake
      getIt<PageManager>().shuffle();
    });
  }

  @override
  void dispose() {
    // getIt<PageManager>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.keyboard_arrow_down_sharp,
              size: 40,
            )),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('Shake and Suffle ON'),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Text("Shake and Suffle OFF"),
                      value: 0,
                    )
                  ],
              onSelected: (value) {
                if (value == 1) {
                  detector.startListening();
                } else {
                  detector.stopListening();
                }
              }),
        ],
      ),
      backgroundColor: black,
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 20),
                      child: Container(
                        width: size.width - 100,
                        height: size.width - 100,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Color(0xFF04be4e),
                              blurRadius: 50,
                              spreadRadius: 5,
                              offset: Offset(-10, 40))
                        ], borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 20),
                        child: CurrentThumbnail(size: size)),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                CurrentSongTitle(),
                SizedBox(
                  height: 80,
                ),
                // AddRemoveSongButtons(),
                AudioProgressBar(),
                AudioControlButtons(),
                SizedBox(
                  height: 300,
                  child: Playlist(),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     getIt<PageManager>().loadArtistSongPlaylist();
                //   },
                //   child: Text(" Play New Playlist"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurrentThumbnail extends StatelessWidget {
  const CurrentThumbnail({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<String>(
      valueListenable: pageManager.currentSongThumbnailNotifier,
      builder: (_, thumnail, __) {
        return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: FadeInImage.assetNetwork(
        image:
            thumnail,
        placeholder: "assets/giphy.gif",
        width: size.width - 60,
        height: size.width - 60,
        fit: BoxFit.cover,
      ),
    );
      },
    );
    
    
  }
}

class CurrentSongTitle extends StatelessWidget {
  const CurrentSongTitle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<String>(
      valueListenable: pageManager.currentSongTitleNotifier,
      builder: (_, title, __) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 150,
              child: Text(
                "This is the song description",
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15, color: Colors.white.withOpacity(0.5)),
              ),
            )
          ],
        );
      },
    );
  }
}

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return Expanded(
      child: ValueListenableBuilder<List<String>>(
        valueListenable: pageManager.playlistNotifier,
        builder: (context, playlistTitles, _) {
          return ListView.builder(
            itemCount: playlistTitles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  '${playlistTitles[index]}',
                  style: TextStyle(color: white),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AddRemoveSongButtons extends StatelessWidget {
  const AddRemoveSongButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: pageManager.add,
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: pageManager.remove,
            child: Icon(Icons.remove),
          ),
        ],
      ),
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
          total: value.total,
          onSeek: pageManager.seek,
          progressBarColor: primary,
          thumbColor: primary,
          timeLabelTextStyle: TextStyle(color: Colors.grey[400]),
          barHeight: 5.0,
        );
      },
    );
  }
}

class AudioControlButtons extends StatelessWidget {
  const AudioControlButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RepeatButton(),
          PreviousSongButton(),
          PlayButton(),
          NextSongButton(),
          ShuffleButton(),
        ],
      ),
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<RepeatState>(
      valueListenable: pageManager.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = Icon(Icons.repeat, color: Colors.grey);
            break;
          case RepeatState.repeatSong:
            icon = Icon(Icons.repeat_one, color: Colors.blue);
            break;
          case RepeatState.repeatPlaylist:
            icon = Icon(Icons.repeat, color: Colors.blue);
            break;
        }
        return IconButton(
          icon: icon,
          onPressed: pageManager.repeat,
        );
      },
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            icon: Icon(Icons.skip_previous_rounded,
                color: isFirst ? Colors.grey : Colors.white, size: 45),
            onPressed: (isFirst) ? null : pageManager.previous,
          ),
        );
      },
    );
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
              width: 40.0,
              height: 40.0,
              child: CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return FloatingActionButton(
              child: Icon(Icons.play_arrow_rounded, color: white, size: 40),
              onPressed: pageManager.play,
              foregroundColor: Colors.black,
              backgroundColor: primary,
            );
          case ButtonState.playing:
            return FloatingActionButton(
              child: Icon(
                Icons.pause_rounded,
                color: white,
                size: 40,
              ),
              onPressed: pageManager.pause,
              foregroundColor: Colors.black,
              backgroundColor: primary,
            );
        }
      },
    );
  }
}

class NextSongButton extends StatelessWidget {
  const NextSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          icon: Icon(
            Icons.skip_next_rounded,
            color: isLast ? Colors.grey : Colors.white,
            size: 45,
          ),
          onPressed: (isLast) ? null : pageManager.next,
        );
      },
    );
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          icon: (isEnabled)
              ? Icon(
                  Icons.shuffle,
                  color: Colors.blue,
                )
              : Icon(Icons.shuffle_outlined, color: Colors.grey),
          onPressed: pageManager.shuffle,
        );
      },
    );
  }
}
