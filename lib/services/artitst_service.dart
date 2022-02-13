import 'dart:convert';

import 'package:get/get.dart';
import 'package:xbeat/services/http_service.dart';
import 'package:xbeat/services/response/getuserprofile.dart';

class ArtistService {
  static Future<UserResponse?> getOwnInfo(String token) async {
    const endpoint = PersistentHtpp.baseUrl + 'artist/';
    var response = await PersistentHtpp.client
        .get(Uri.parse(endpoint), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return UserResponse.fromJson(json);
    } else if (response.statusCode >= 500) {
      Get.snackbar('Error', 'Server error');
      return null;
    }
    return null;
  }
}
