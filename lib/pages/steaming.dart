import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'page_manager.dart';
import 'package:flutter/material.dart';
import '../notifiers/play_button_notifier.dart';
import '../notifiers/progress_notifier.dart';
import '../notifiers/repeat_button_notifier.dart';

class StreamApp extends StatefulWidget {
  const StreamApp({Key? key}) : super(key: key);

  @override
  _StreamAppState createState() => _StreamAppState();
}

// use GetIt or Provider rather than a global variable in a real project
late final PageManager _pageManager;

class _StreamAppState extends State<StreamApp> {
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
            CurrentSongTitle(),
            Playlist(),
            AddRemoveSongButtons(),
            AudioProgressBar(),
            AudioControlButtons(),
          ],
        ),
      ),
    );
  }
}

class CurrentSongTitle extends StatelessWidget {
  const CurrentSongTitle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: _pageManager.currentSongTitleNotifier,
      builder: (_, title, __) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(title,
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              )),
        );
      },
    );
  }
}

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<String>>(
        valueListenable: _pageManager.playlistNotifier,
        builder: (context, playlistTitles, _) {
          return ListView.builder(
            itemCount: playlistTitles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  '${playlistTitles[index]}',
                  style: TextStyle(color: Colors.white),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: _pageManager.addSong,
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: _pageManager.removeSong,
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
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: _pageManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: _pageManager.seek,
          timeLabelTextStyle: TextStyle(color: Colors.grey[400]),
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
    return ValueListenableBuilder<RepeatState>(
      valueListenable: _pageManager.repeatButtonNotifier,
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
          onPressed: _pageManager.onRepeatButtonPressed,
        );
      },
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            icon: Icon(Icons.skip_previous_rounded,
                color: isFirst ? Colors.grey : Colors.white, size: 45),
            onPressed:
                (isFirst) ? null : _pageManager.onPreviousSongButtonPressed,
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
    return ValueListenableBuilder<ButtonState>(
      valueListenable: _pageManager.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: EdgeInsets.all(10.0),
              width:40.0,
              height: 40.0,
              child: CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return FloatingActionButton(
              child:
                  Icon(Icons.play_arrow_rounded, color: Colors.black, size:40),
              onPressed: _pageManager.play,
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,

            );
          case ButtonState.playing:
            return FloatingActionButton(
              child: Icon(
                Icons.pause_rounded,
                color: Colors.black,
                size: 40,
              ),
              onPressed: _pageManager.pause,
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
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
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          icon: Icon(
            Icons.skip_next_rounded,
            color: isLast ? Colors.grey : Colors.white,
            size: 45,
          ),
          onPressed: (isLast) ? null : _pageManager.onNextSongButtonPressed,
        );
      },
    );
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          icon: (isEnabled)
              ? Icon(
                  Icons.shuffle,
                  color: Colors.blue,
                )
              : Icon(Icons.shuffle_outlined, color: Colors.grey),
          onPressed: _pageManager.onShuffleButtonPressed,
        );
      },
    );
  }
}
