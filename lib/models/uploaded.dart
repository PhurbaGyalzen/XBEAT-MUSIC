
import 'dart:convert';

UploadedSongResponse uploadedSongResponseFromJson(String str) => UploadedSongResponse.fromJson(json.decode(str));

String uploadedSongResponseToJson(UploadedSongResponse data) => json.encode(data.toJson());

class UploadedSongResponse {
    UploadedSongResponse({
        required this.message,
        required this.song,
    });

    String message;
    Song song;

    factory UploadedSongResponse.fromJson(Map<String, dynamic> json) => UploadedSongResponse(
        message: json["message"],
        song: Song.fromJson(json["song"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "song": song.toJson(),
    };
}

class Song {
    Song({
        required this.title,
        required this.artist,
        required this.url,
        required this.thumbnail,
        required this.likes,
        required this.comments,
        required this.id,
        required this.v,
    });

    String title;
    String artist;
    String url;
    String thumbnail;
    List<dynamic> likes;
    List<dynamic> comments;
    String id;
    int v;

    factory Song.fromJson(Map<String, dynamic> json) => Song(
        title: json["title"],
        artist: json["artist"],
        url: json["url"],
        thumbnail: json["thumbnail"],
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        id: json["_id"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "artist": artist,
        "url": url,
        "thumbnail": thumbnail,
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "_id": id,
        "__v": v,
    };
}
