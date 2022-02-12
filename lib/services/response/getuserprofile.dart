import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
    UserResponse({
        required this.message,
        required this.artist,
    });

    String message;
    Artist artist;

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        message: json["message"],
        artist: Artist.fromJson(json["artist"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "artist": artist.toJson(),
    };
}

class Artist {
    Artist({
        required this.id,
        required this.username,
        required this.profile,
        required this.followers,
        required this.following,
        required this.albums,
        required this.songs,
        required this.likedSongs,
        required this.comments,
        required this.role,
        required this.isBlocked,
        required this.playList,
        required this.joinedAt,
        required this.v,
    });

    String id;
    String username;
    String profile;
    List<dynamic> followers;
    List<dynamic> following;
    List<dynamic> albums;
    List<String> songs;
    List<dynamic> likedSongs;
    List<dynamic> comments;
    String role;
    bool isBlocked;
    List<dynamic> playList;
    DateTime joinedAt;
    int v;

    factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json["_id"],
        username: json["username"],
        profile: json["profile"],
        followers: List<dynamic>.from(json["followers"].map((x) => x)),
        following: List<dynamic>.from(json["following"].map((x) => x)),
        albums: List<dynamic>.from(json["albums"].map((x) => x)),
        songs: List<String>.from(json["songs"].map((x) => x)),
        likedSongs: List<dynamic>.from(json["likedSongs"].map((x) => x)),
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        role: json["role"],
        isBlocked: json["isBlocked"],
        playList: List<dynamic>.from(json["playList"].map((x) => x)),
        joinedAt: DateTime.parse(json["joinedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "profile": profile,
        "followers": List<dynamic>.from(followers.map((x) => x)),
        "following": List<dynamic>.from(following.map((x) => x)),
        "albums": List<dynamic>.from(albums.map((x) => x)),
        "songs": List<dynamic>.from(songs.map((x) => x)),
        "likedSongs": List<dynamic>.from(likedSongs.map((x) => x)),
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "role": role,
        "isBlocked": isBlocked,
        "playList": List<dynamic>.from(playList.map((x) => x)),
        "joinedAt": joinedAt.toIso8601String(),
        "__v": v,
    };
}
