import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExitScreen extends StatefulWidget {
  @override
  _ExitScreenState createState() => _ExitScreenState();
}

class _ExitScreenState extends State<ExitScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Center(
                child: FlatButton(
                  color: Colors.redAccent,
                  splashColor: Colors.blue,
                  padding: EdgeInsets.all(25.0),
                  child: Text(
                    "Logout",
                    style: TextStyle(fontSize: 40.0,color: Colors.white,fontWeight: FontWeight.w400),
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
