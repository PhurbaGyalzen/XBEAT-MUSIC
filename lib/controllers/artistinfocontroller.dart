import 'package:get/get.dart';
import 'package:xbeat/services/artitst_service.dart';
import 'package:xbeat/services/http_service.dart';

class ArtistInfoController extends GetxController {
  var isLoading = true.obs;
  var id = "".obs;
  var username = "".obs;
  var firstName = "".obs;
  var lastName = "".obs;
  var description = "".obs;
  var profile = "".obs;
  var followers = 0.obs;
  var following = 0.obs;
  var songs = [].obs;
  var albums = [].obs;
  var playlists = [].obs;
  var likedSongs = [].obs;

  String token;

  ArtistInfoController(this.token);
  @override
  void onInit() {
    super.onInit();
    fetchInfo(token);
  }

  void fetchInfo(String token) async {
    try {
      isLoading.value = true;
      var responseSongs = await ArtistService.getOwnInfo(token);
      if (responseSongs != null) {
        id.value = responseSongs.artist.id;
        username.value = responseSongs.artist.username;
        firstName.value = responseSongs.artist.firstName;
        lastName.value = responseSongs.artist.lastName;
        description.value = responseSongs.artist.description;
        profile.value = PersistentHtpp.baseUrl + responseSongs.artist.profile;
        followers.value = responseSongs.artist.followers.length;
        following.value = responseSongs.artist.following.length;
        songs.value = responseSongs.artist.songs;
        albums.value = responseSongs.artist.albums;
        playlists.value = responseSongs.artist.playList;
        likedSongs.value = responseSongs.artist.likedSongs;
      } else {
        Get.snackbar("Error", "Something went wrong",
            snackPosition: SnackPosition.BOTTOM);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
