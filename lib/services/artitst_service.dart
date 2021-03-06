import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:xbeat/controllers/artistinfocontroller.dart';
import 'package:xbeat/services/http_service.dart';
import 'package:xbeat/services/response/getuserprofile.dart';
import 'package:xbeat/theme/colors.dart';

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

  static void updateDetails(
    String token,
    String firstName,
    String lastName,
    String description,
  ) async {
    const endpoint = PersistentHtpp.baseUrl + 'artist/detail';

    var response = await PersistentHtpp.client.patch(
      Uri.parse(endpoint),
      body: {
        "firstName": firstName,
        "lastName": lastName,
        "description": description
      },
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      Get.snackbar(
        "Profile Details Updated",
        "Your profile details has been updated!!!",
        icon: Icon(Icons.person_rounded, color: white),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green[700],
        colorText: white,
        animationDuration: Duration(seconds: 2),
        dismissDirection: DismissDirection.horizontal,
        snackPosition: SnackPosition.TOP,
      );
      late ArtistInfoController artistInfoController = Get.find();
      artistInfoController.firstName.value = firstName;
      artistInfoController.lastName.value = lastName;
      artistInfoController.description.value = description;
    } else if (response.statusCode >= 500) {
      Get.snackbar(
        "Something went wrong",
        "Cannot Update your Profile details",
        icon: Icon(Icons.warning, color: white),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red[700],
        colorText: white,
        animationDuration: Duration(seconds: 2),
        dismissDirection: DismissDirection.horizontal,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  static void updateProfile(File file, String token) async {
    var http = dio.Dio();

    var filename = file.path;

    var formData = dio.FormData.fromMap({
      'image': await dio.MultipartFile.fromFile(file.path, filename: filename),
    });
    var response = await http.patch(
      PersistentHtpp.baseUrl + "artist/profile",
      data: formData,
      options: dio.Options(
        headers: {
          'Authorization': 'Bearer ' + token,
        },
      ),
    );
    if (response.statusCode == 200) {
      Get.snackbar(
        "Profile Updated",
        "Your profile picture has been updated!!!",
        icon: Icon(Icons.person_rounded, color: white),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green[700],
        colorText: white,
        animationDuration: Duration(seconds: 2),
        dismissDirection: DismissDirection.horizontal,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      Get.snackbar(
        "Something went wrong",
        "Cannot update your profile picture",
        icon: Icon(Icons.person_rounded, color: white),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red[700],
        colorText: white,
        animationDuration: Duration(seconds: 2),
        dismissDirection: DismissDirection.horizontal,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
