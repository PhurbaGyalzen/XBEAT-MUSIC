import 'dart:convert';

import 'package:get/get.dart';
import 'package:xbeat/models/songs.dart';
import 'package:xbeat/services/http_service.dart';

class SongsService {
  static Future<ArtistSongs?> getArtistSongs(String token) async {
    var endpoint = PersistentHtpp.baseUrl + 'songs';
    var response = await PersistentHtpp.client
        .get(Uri.parse(endpoint), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return ArtistSongs.fromJson(json);
    } else if (response.statusCode >= 500) {
      Get.snackbar('Error', 'Server error');
      return null;
    }
    return null;
  }

  static Future<int> deleteSong(String token, String id) async {
    var endpoint = PersistentHtpp.baseUrl + 'artist/song/' + '$id';
    var response = await PersistentHtpp.client.delete(Uri.parse(endpoint),
        headers: {'Authorization': 'Bearer $token'});
    return response.statusCode;
  }
}
