import 'package:xbeat/services/http_service.dart';
import 'dart:convert';

class AuthService {
  static Future<LoginResponse?> login(String username, String password) async {
    const endpoint = PersistentHtpp.baseUrl + 'artist/login';
    var response = await PersistentHtpp.client.post(Uri.parse(endpoint), body: {
      'username': username,
      'password': password,
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return LoginResponse.fromJson(json);
    } else {
      return null;
    }
  }

  static Future<RegisterArtistResponse?> register(String firstName, String fastName, String username, String password) async {
    const endpoint = PersistentHtpp.baseUrl + 'artist/register';
    var response = await PersistentHtpp.client.post(Uri.parse(endpoint), body: {
      'firstName': firstName,
      'lastName': fastName,
      'username': username,
      'password': password,
    });
    if (response.statusCode == 201) {
      var json = jsonDecode(response.body);
      return RegisterArtistResponse.fromJson(json);
    } else {
      return null;
    }
  }
}

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.token,
    required this.role,
    required this.message,
    required this.user_id,
  });

  String message;
  String token;
  String role;
  String user_id;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        message: json["message"],
        token: json["token"],
        user_id: json["user_id"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "role": role,
        "user_id": user_id,
      };
}


RegisterArtistResponse registerArtistResponseFromJson(String str) => RegisterArtistResponse.fromJson(json.decode(str));

String registerArtistResponseToJson(RegisterArtistResponse data) => json.encode(data.toJson());

class RegisterArtistResponse {
    RegisterArtistResponse({
        required this.artist,
        required this.message,
        required this.token,
    });

    String message;
    Artist artist;
    String token;

    factory RegisterArtistResponse.fromJson(Map<String, dynamic> json) => RegisterArtistResponse(
        message: json["message"],
        artist: Artist.fromJson(json["artist"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "artist": artist.toJson(),
        "token": token,
    };
}

class Artist {
    Artist({
        required this.username,
        required this.password,
        required this.firstName,
        required this.lastName,
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
        required this.id,
        required this.joinedAt,
        required this.v,
    });

    String username;
    String password;
    String firstName;
    String lastName;
    String profile;
    List<dynamic> followers;
    List<dynamic> following;
    List<dynamic> albums;
    List<dynamic> songs;
    List<dynamic> likedSongs;
    List<dynamic> comments;
    String role;
    bool isBlocked;
    List<dynamic> playList;
    String id;
    DateTime joinedAt;
    int v;

    factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        username: json["username"],
        password: json["password"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profile: json["profile"],
        followers: List<dynamic>.from(json["followers"].map((x) => x)),
        following: List<dynamic>.from(json["following"].map((x) => x)),
        albums: List<dynamic>.from(json["albums"].map((x) => x)),
        songs: List<dynamic>.from(json["songs"].map((x) => x)),
        likedSongs: List<dynamic>.from(json["likedSongs"].map((x) => x)),
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        role: json["role"],
        isBlocked: json["isBlocked"],
        playList: List<dynamic>.from(json["playList"].map((x) => x)),
        id: json["_id"],
        joinedAt: DateTime.parse(json["joinedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
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
        "_id": id,
        "joinedAt": joinedAt.toIso8601String(),
        "__v": v,
    };
}
