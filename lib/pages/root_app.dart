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
      backgroundColor: Colors.black,
      body: getBody(),
      bottomNavigationBar: getButtomAppBar(),
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

  Widget getButtomAppBar() {
    return (BottomAppBar(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    activeTab = 0;
                  });
                },
                icon: Icon(
                  Icons.home,
                  color: activeTab == 0 ? Colors.blue[300] : Colors.white,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    activeTab = 1;
                  });
                },
                icon: Icon(
                  Icons.library_add_check,
                  color: activeTab == 1 ? Colors.blue[300] : Colors.white,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    activeTab = 2;
                  });
                },
                icon: Icon(
                  Icons.search,
                  semanticLabel: "Search",
                  color: activeTab == 2 ? Colors.blue[300] : Colors.white,
                )),
            IconButton(
              onPressed: () {
                setState(() {
                  activeTab = 3;
                });
              },
              icon: Icon(
                Icons.settings,
                color: activeTab == 3 ? Colors.blue[300] : Colors.white,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
