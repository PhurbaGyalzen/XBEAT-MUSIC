import 'package:flutter/material.dart';
import 'package:xbeat/pages/home.dart';
// import 'package:xbeat/pages/login.dart';
import 'package:xbeat/pages/miniplayer.dart';
import 'package:xbeat/pages/ownprofile.dart';
import 'package:xbeat/pages/upload_song.dart';
import '../theme/colors.dart';
import 'package:get/get.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      body: SafeArea(child: getBody()),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: _getNavigationBar(
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: activeTab,
      children: [
        Home(),
        UploadSongScreen(),
        ProfileScreen(),
      ],
    );
  }

  Widget _getNavigationBar() {
    void _onItemTapped(int index) {
      setState(() {
        activeTab = index;
      });
    }

    return BottomNavigationBar(
        landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
        elevation: 0, // to get rid of the shadow
        currentIndex: activeTab,
        selectedItemColor: Colors.deepOrange[200],
        onTap: _onItemTapped,
        backgroundColor: Color(
            0xA6000000), // transparent, you could use 0x44aaaaff to make it slightly less transparent with a blue hue.
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Add Music',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ]);
  }
}

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: GestureDetector(
          onTap: () {
            Get.to(TestScreen());
          },
          child: Text(
            "Search",
            style: TextStyle(color: white),
          ),
        ),
      ),
    );
  }
}
