import 'package:flutter/material.dart';
import 'package:xbeat/pages/home.dart';

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
      body: getBody(),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: _getNavigationBar(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: activeTab,
      children: [
        Home(),
        Center(
          child: Text(
            'Library',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Center(
          child: Text(
            'Bookmark',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Center(
          child: Text(
            'Settings',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
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
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ]);
  }
}
