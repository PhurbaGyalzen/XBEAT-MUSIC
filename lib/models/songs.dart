import 'dart:convert';

ArtistSongs artistSongsFromJson(String str) => ArtistSongs.fromJson(json.decode(str));

String artistSongsToJson(ArtistSongs data) => json.encode(data.toJson());

class ArtistSongs {
    ArtistSongs({
        required this.message,
        required this.artistName,
        required this.songs,
    });

    String message;
    String artistName;
    List<Song> songs;

    factory ArtistSongs.fromJson(Map<String, dynamic> json) => ArtistSongs(
        message: json["message"],
        artistName: json["artist_name"],
        songs: List<Song>.from(json["songs"].map((x) => Song.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "artist_name": artistName,
        "songs": List<dynamic>.from(songs.map((x) => x.toJson())),
    };
}

class Song {
    Song({
        required this.id,
        required this.title,
        required this.artist,
        required this.url,
        required this.thumbnail,
        required this.likes,
        required this.comments,
        required this.v,
    });

    String id;
    String title;
    String artist;
    String url;
    String thumbnail;
    List<dynamic> likes;
    List<dynamic> comments;
    int v;

    factory Song.fromJson(Map<String, dynamic> json) => Song(
        id: json["_id"],
        title: json["title"],
        artist: json["artist"],
        url: json["url"],
        thumbnail: json["thumbnail"],
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "artist": artist,
        "url": url,
        "thumbnail": thumbnail,
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "__v": v,
    };
}
