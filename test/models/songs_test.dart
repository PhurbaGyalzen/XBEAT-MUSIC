import 'package:flutter_test/flutter_test.dart';
import 'package:xbeat/models/songs.dart';

void main() {
  group("Songs Model", () {
    test('Giving Songs songs json when calling fromJson gives Song object',
        () async {
      // ignore: todo
      // TODO: Implement

      // Arrange
      List<Map<String, dynamic>> songs = [
        {
          "_id": "621bb346a80210344cbeb93e",
          "title": "Stay",
          "artist": "6218cae135fdbdfd8a8ca811",
          "url": "stream/song/audio-1645982534116.mp3",
          "thumbnail": "images/thumbnail/thumbnail-1645982534161.jpg",
          "likes": [],
          "comments": [],
          "__v": 0
        },
        {
          "_id": "621bb7bfa80210344cbeb94c",
          "title": "Enemy",
          "artist": "6218cae135fdbdfd8a8ca811",
          "url": "stream/song/audio-1645983679613.mp3",
          "thumbnail": "images/thumbnail/thumbnail-1645983679663.jpg",
          "likes": [],
          "comments": [],
          "__v": 0
        },
      ];

      // Act
      List<Song> songsObjects =
          songs.map((song) => Song.fromJson(song)).toList();

      // Assert
      expect(songsObjects.length, 2);
      expect(songsObjects[0].title, 'Stay');
      expect(songsObjects[1].title, 'Enemy');
    });
    test('Testing if Songs.fromJson works with empty json', () async {
      // ignore: todo
      // TODO: Implement

      // Arrange
      List<Map<String, dynamic>> songs = [];

      // Act
      List<Song> songsObjects =
          songs.map((song) => Song.fromJson(song)).toList();

      // Assert
      expect(songsObjects.length, 0);
    });
    test('Check if Song.toJson converts the Song instance to a Map Object', () async {
      // ignore: todo
      // TODO: Implement

      // Arrange
      Song song = Song(
          id: '621bb346a80210344cbeb93e',
          title: 'Stay',
          artist: '6218cae135fdbdfd8a8ca811',
          url: 'stream/song/audio-1645982534116.mp3',
          thumbnail: 'images/thumbnail/thumbnail-1645982534161.jpg',
          likes: [],
          comments: [],
          v: 0);

      // Act
      Map<String, dynamic> songJson = song.toJson();

      // Assert
      expect(songJson['_id'], '621bb346a80210344cbeb93e');
      expect(songJson['title'], 'Stay');
      expect(songJson['artist'], '6218cae135fdbdfd8a8ca811');
      expect(songJson['url'], 'stream/song/audio-1645982534116.mp3');
      expect(songJson['thumbnail'], 'images/thumbnail/thumbnail-1645982534161.jpg');
      expect(songJson['likes'], []);
      expect(songJson['comments'], []);
      expect(songJson['__v'], 0);
    });
  });
}
