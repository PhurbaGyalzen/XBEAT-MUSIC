import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:xbeat/services/songs_service.dart';
import 'package:xbeat/theme/colors.dart';

class UploadSongScreen extends StatefulWidget {
  const UploadSongScreen({Key? key}) : super(key: key);

  @override
  _UploadSongScreenState createState() => _UploadSongScreenState();
}

class _UploadSongScreenState extends State<UploadSongScreen> {
  late final Box authbox;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    // Get reference to an already opened box
    authbox = await Hive.openBox('auth');
  }

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final titleEditingController = new TextEditingController();
  var audioFile = '';
  var imageFile = '';
  late File thumbnail;
  late File audio;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    //first name field
    final firstNameField = TextFormField(
        autofocus: false,
        controller: titleEditingController,
        keyboardType: TextInputType.name,
        cursorColor: black,
        onSaved: (value) {
          titleEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.title),
          fillColor: white,
          filled: true,
          hintStyle: TextStyle(color: grey),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Title",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final uploadSongButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: grey,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            uploadSong(titleEditingController.text, thumbnail, audio);
          },
          child: Text(
            "Add Song",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    Future<File?> pickImage() async {
      // Lets the user pick one file, but only files with the extensions `svg` and `pdf` can be selected
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['png', 'jpg', 'gif']);

// The result will be null, if the user aborted the dialog
      if (result != null) {
        File file = File(result.files.first.path!);
        setState(() {
          imageFile = result.files.first.path!.split("/").last;
          thumbnail = file;
        });
        return file;
      }
    }

    final pickImageButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: primary,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            pickImage();
          },
          child: Text(
            "Upload Thumbnail",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    Future<File?> pickAudio() async {
      // Lets the user pick one file, but only files with the extensions `svg` and `pdf` can be selected
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.audio);

// The result will be null, if the user aborted the dialog
      if (result != null) {
        File file = File(result.files.first.path!);
        setState(() {
          audioFile = result.files.first.path!.split("/").last;
          audio = file;
        });
        return file;
      }
    }

    final pickAudioButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: primary,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            pickAudio();
          },
          child: Text(
            "Upload Audio",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: black,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 180,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/logo2.png",
                            fit: BoxFit.contain,
                          ),
                        )),
                    SizedBox(height: 45),
                    firstNameField,
                    SizedBox(height: 20),
                    Text(
                      imageFile,
                      style:
                          TextStyle(color: white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    pickImageButton,
                    SizedBox(height: 20),
                    Text(
                      audioFile,
                      style:
                          TextStyle(color: white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    pickAudioButton,
                    SizedBox(height: 20),
                     Container(child: isLoading? CircularProgressIndicator(): uploadSongButton),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void uploadSong(String title, File thumbnail, File audio) async {
    setState(() {
      isLoading = true;
    });
    var res = await SongsService.uploadSong(
        authbox.get('token'), title, thumbnail, audio);
    if (res != null) {
      setState(() {
        titleEditingController.text = '';
        audioFile = '';
        imageFile = '';
        isLoading = false;
      });
      Get.snackbar(
        "sucess",
        "Song added successfully",
        backgroundColor: primary,
        colorText: white,
      );
    }
  }
}
