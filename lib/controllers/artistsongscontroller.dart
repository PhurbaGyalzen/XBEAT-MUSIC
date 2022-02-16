import 'package:get/get.dart';
import 'package:xbeat/services/http_service.dart';
import 'package:xbeat/services/songs_service.dart';

class ArtistSongsController extends GetxController {
  var isLoading = true.obs;
  var artist = "".obs;
  var songs = [].obs;

  String token;

  ArtistSongsController(this.token);
  @override
  void onInit() {
    super.onInit();
    fetchSongs(token);
  }

  void fetchSongs(String token) async {
    try {
      isLoading.value = true;
      var responseSongs = await SongsService.getArtistSongs(token);
      if (responseSongs != null) {
        var finalsongs = responseSongs.songs.map((song) {
          var songurl = song.url;
          var thumbnail = song.thumbnail;
          song.url = PersistentHtpp.baseUrl + songurl;
          song.thumbnail = PersistentHtpp.baseUrl + thumbnail;
          return song;
        }).toList();
        songs.value = finalsongs;
        artist.value = responseSongs.artistName;
      } else {
        Get.snackbar("Error", "Something went wrong",
            snackPosition: SnackPosition.BOTTOM);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
