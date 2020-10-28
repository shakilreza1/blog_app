import 'package:blogg_app/exit.dart';
import 'package:blogg_app/views/create_blog.dart';
import 'package:blogg_app/views/home.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';


class ScreenPage extends StatefulWidget {
  @override
  _ScreenPageState createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  int _indexPage = 1;
  final pageOptions = [
    ExitScreen(),
    HomePage(),
    CreateBlog(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: pageOptions[_indexPage],
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        backgroundColor: Colors.lightBlueAccent.withOpacity(0.4),
        items: <Widget>[
          Icon(Icons.exit_to_app, size: 40,color: Colors.redAccent),
          Icon(Icons.home, size: 40,color: Colors.tealAccent),
          Icon(Icons.camera_alt, size: 40,color: Colors.orangeAccent,),
        ],
        onTap: (int index){
          setState(() {
            _indexPage = index;
          });
        },
      ),
    );
  }
}
