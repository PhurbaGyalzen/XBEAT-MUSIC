import 'package:xbeat/services/http_service.dart';
import 'dart:convert';

class AuthService {
  static Future<LoginResponse?> login (String username, String password) async {
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
