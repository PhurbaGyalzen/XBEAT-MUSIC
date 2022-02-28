import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:xbeat/models/songs.dart';
import 'package:xbeat/models/uploaded.dart';
import 'package:xbeat/services/http_service.dart';
import 'package:dio/dio.dart' as dio;

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

  static Future<Map<String, dynamic>?> uploadSong(
      String token, String title, File thumbnail, File audio) async {
    var http = dio.Dio();
    var endpoint = PersistentHtpp.baseUrl + 'upload/song';
    var thumbnailFileName = thumbnail.path;

    var formData = dio.FormData.fromMap({
      'title': title,
      'thumbnail': await dio.MultipartFile.fromFile(thumbnail.path,
          filename: thumbnailFileName),
      'audio':
          await dio.MultipartFile.fromFile(audio.path, filename: audio.path),
    });
    var response = await http.post(
      endpoint,
      data: formData,
      options: dio.Options(
        headers: {
          'Authorization': 'Bearer ' + token,
        },
      ),
    );

    if (response.statusCode == 201) {
      return response.data;
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
