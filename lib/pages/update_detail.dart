import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:xbeat/controllers/artistinfocontroller.dart';
import 'package:xbeat/controllers/artistsongscontroller.dart';
import 'package:xbeat/services/artitst_service.dart';
// import 'package:xbeat/pages/root_app.dart';
import 'package:xbeat/theme/colors.dart';

class UpdateDetailScreen extends StatefulWidget {
  const UpdateDetailScreen({Key? key}) : super(key: key);

  @override
  _UpdateDetailScreenState createState() => _UpdateDetailScreenState();
}

class _UpdateDetailScreenState extends State<UpdateDetailScreen> {
  late final Box authbox;
  late ArtistInfoController artistInfoController = Get.find();
  ArtistSongsController artistSongsController = Get.find();

  @override
  void initState() {
    firstNameEditingController.text = artistInfoController.firstName.toString();
    lastNameEditingController.text = artistInfoController.lastName.toString();
    bioEditingController.text = artistInfoController.description.toString();
    super.initState();
    init();
  }

  void init() async {
    // Get reference to an already opened box
    authbox = await Hive.openBox('auth');
  }

  bool hiddenPassword = true;
  bool hiddenPassword2 = true;
  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final firstNameEditingController = new TextEditingController();
  final lastNameEditingController = new TextEditingController();
  final bioEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //first name field
    final firstNameField = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        cursorColor: black,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          fillColor: white,
          filled: true,
          hintStyle: TextStyle(color: grey),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //last name field
    final lastNameField = TextFormField(
        autofocus: false,
        controller: lastNameEditingController,
        keyboardType: TextInputType.name,
        cursorColor: black,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Second Name cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          lastNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          fillColor: white,
          filled: true,
          hintStyle: TextStyle(color: grey),
          hintText: "Last Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //bio name field
    final bioField = TextFormField(
        autofocus: false,
        controller: bioEditingController,
        keyboardType: TextInputType.multiline,
        cursorColor: black,
        validator: (value) {
          if (value!.isEmpty) {
            return ("bio cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          lastNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.newline,
        minLines: 1,
        maxLines: 5,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.info),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          fillColor: white,
          filled: true,
          hintStyle: TextStyle(color: grey),
          hintText: "bio",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //signup button
    final Update = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: primary,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            updateDetail(firstNameEditingController.text,
                lastNameEditingController.text, bioEditingController.text);
          },
          child: Text(
            "Update",
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
        leading: IconButton(
          icon: Icon(
            Icons.cancel_rounded,
            color: Colors.red,
            size: 40,
          ),
          onPressed: () {
            // passing this to our root
            Get.back();
          },
        ),
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
                          child: Image.network(
                            artistInfoController.profile.toString(),
                            fit: BoxFit.contain,
                          ),
                        )),
                    SizedBox(height: 45),
                    firstNameField,
                    SizedBox(height: 20),
                    lastNameField,
                    SizedBox(height: 20),
                    bioField,
                    SizedBox(height: 20),
                    Update,
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

  void updateDetail(
      String firstName, String lastName, String description) async {
    if (_formKey.currentState!.validate()) {
      print(firstName + lastName + description);
      ArtistService.updateDetails(
          authbox.get('token'), firstName, lastName, description);
      Get.back();
    }
  }
}
