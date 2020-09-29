import 'package:flutter/material.dart';
import 'groups.dart';
import 'add.dart';
import 'profilepage.dart';
import 'home_view.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    AddPage(),
    GroupPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YOLO"),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("Home"),
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.add),
              title: new Text("Add"),
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.group),
              title: new Text("Groups"),
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              title: new Text("Profile"),
              backgroundColor: Colors.blue,
            ),
          ]
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}