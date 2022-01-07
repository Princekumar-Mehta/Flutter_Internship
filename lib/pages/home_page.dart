import "package:flutter/material.dart";
import 'package:flutter_app_crash_course_2/utils/routes.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title:Text("Catalog App"),
        ),
        body: Center(
          child: Container(
            child: ElevatedButton(
              child: Text('Enter'),
              style:TextButton.styleFrom(backgroundColor: Colors.blue,minimumSize: Size(300,100)),
              onPressed: (){
                Navigator.pushNamed(context,MyRoutes.loginRoute);
              },
            ),
          )
        ),
        drawer : Drawer(),
      )
    );
  }
}
