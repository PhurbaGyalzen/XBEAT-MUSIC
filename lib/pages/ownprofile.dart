import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:xbeat/controllers/artistinfocontroller.dart';
import 'package:xbeat/controllers/artistsongscontroller.dart';
import 'package:xbeat/pages/login.dart';
import 'package:xbeat/pages/page_manager.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:xbeat/pages/page_manager.dart';
import 'package:xbeat/pages/steaming.dart';
import 'package:xbeat/pages/update_detail.dart';
import 'package:xbeat/services/artitst_service.dart';
import 'package:xbeat/services/service_locator.dart';
// import 'package:xbeat/services/http_service.dart';
// import 'package:xbeat/services/service_locator.dart';
import 'package:xbeat/theme/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final Box authbox;
  late final ArtistInfoController artistInfoController;
  late final ArtistSongsController artistSongsController;
  final ImagePicker imagePicker = ImagePicker();
  late File? pickedImage = null;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void init() async {
    // Get reference to an already opened box
    authbox = await Hive.openBox('auth');
    artistInfoController = Get.put(ArtistInfoController(authbox.get('token')));
    artistSongsController =
        Get.put(ArtistSongsController(authbox.get('token')));
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      ArtistService.updateProfile(tempImage, authbox.get('token'));
      print(photo.path);
      setState(() {
        pickedImage = tempImage;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: black,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Update your profile picture from",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: primary, // Background color
                    ),
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: primary, // Background color
                    ),
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: primary, // Background color
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("CANCEL"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: black,
            title: Text(
              artistInfoController.username.toString(),
            ),
            centerTitle: false,
            actions: [
              PopupMenuButton(
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('Edit Details'),
                          value: 1,
                          height: 30,
                        ),
                      ],
                  onSelected: (value) {
                    if (value == 1) {
                      Get.to(() => UpdateDetailScreen());
                    }
                  }),
            ],
          ),
          backgroundColor: black,
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          child: ClipRRect(
                            child: pickedImage != null
                                ? Image.file(
                                    pickedImage!,
                                    height: 90,
                                    width: 90,
                                  )
                                : Image.network(
                                    "${artistInfoController.profile}",
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          onTap: () {
                            imagePickerOption();
                          },
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildStatColumn(
                                      artistSongsController.songs.length,
                                      "songs"),
                                  buildStatColumn(
                                      artistInfoController.followers.toInt(),
                                      "followers"),
                                  buildStatColumn(
                                      artistInfoController.following.toInt(),
                                      "following"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FollowButton(
                                    text: 'Sign Out',
                                    backgroundColor: black,
                                    textColor: white,
                                    borderColor: Colors.grey,
                                    function: () async {
                                      await authbox.delete('token');
                                      Get.offAll(() => LoginScreen());
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(
                        top: 15,
                      ),
                      child: Text(
                        artistInfoController.firstName.toString() +
                            " " +
                            artistInfoController.lastName.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: white),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(
                        top: 1,
                      ),
                      child: Text(artistInfoController.description.toString(),
                          style: TextStyle(color: white)),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: white,
              ),
              SizedBox(
                  height: 150,
                  child: ListView.builder(
                    itemCount: artistSongsController.songs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            pageManager.loadNewPlaylist();
                            Get.to(StreamApp());
                          },
                          leading: FadeInImage.assetNetwork(
                              placeholder: "assets/splash.png",
                              image:
                                  artistSongsController.songs[index].thumbnail),
                          title: Text(
                            artistSongsController.songs[index].title,
                            style: TextStyle(color: white),
                          ),
                        ),
                      );
                    },
                  ))
            ],
          ),
        ));
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: white),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}

class FollowButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;
  const FollowButton(
      {Key? key,
      required this.backgroundColor,
      required this.borderColor,
      required this.text,
      required this.textColor,
      this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          width: 250,
          height: 27,
        ),
      ),
    );
  }
}
