abstract class PlaylistRepository {
  Future<List<Map<String, String>>> fetchInitialPlaylist();
  Future<List<Map<String, String>>> fetchNextPlaylist();
  Future<Map<String, String>> fetchAnotherSong();
}

class DemoPlaylist extends PlaylistRepository {
  @override
  Future<List<Map<String, String>>> fetchInitialPlaylist(
      {int length = 3}) async {
    var result = List.generate(length, (index) => _nextSong());
    print(result);
    return result;
  }

  @override
  Future<List<Map<String, String>>> fetchNextPlaylist() async {
    var result = [
      {
        'id': '010',
        'title': 'Real Friends',
        'album': 'Album Name',
        'url':
            'http://192.168.1.17:3000/stream/song/Real Friends - CAMILA CABELLO ft SWAE LEE.mp3'
      },
      {
        'id': '022',
        'title': 'Infoki',
        'album': 'Album Name',
        'url':
            'http://192.168.1.17:3000/stream/song/indie-folk-king-around-here-15045.mp3'
      }
    ];
    return result;
  }

  @override
  Future<Map<String, String>> fetchAnotherSong() async {
    return _nextSong();
  }

  var _songIndex = 0;
  static const _maxSongNumber = 16;

  Map<String, String> _nextSong() {
    _songIndex = (_songIndex % _maxSongNumber) + 1;
    return {
      'id': _songIndex.toString().padLeft(3, '0'),
      'title': 'Song $_songIndex',
      'album': 'Album Name',
      'url':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-$_songIndex.mp3',
    };
  }
}
