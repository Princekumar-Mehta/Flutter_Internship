import 'package:flutter/material.dart';
import 'package:project_2/gmail_login.dart';
import 'package:project_2/image_upload.dart';
import 'package:project_2/view_users.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Gmail_Login()),
                );
              },
              child: Text("Login"),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const View_Users()),
                );
              },
              child: Text("View Current Users"),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Image_Upload()),
                );
              },
              child: Text("Image Upload"),
            ),
          ],
        ),
      ),
    );
  }
}
