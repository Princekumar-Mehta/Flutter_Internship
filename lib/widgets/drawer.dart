import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageURL ="";
    return Drawer(
      child:
      Container(
        color:Colors.deepPurple,
        child: ListView(
            padding: EdgeInsets.zero,
            children :[
              DrawerHeader(
                  child: UserAccountsDrawerHeader(
                    margin: EdgeInsets.zero,
                    accountName: Text('Prince Mehta'),
                    accountEmail:Text('Prince@gmail.com'),
                    currentAccountPicture: CircleAvatar(
                     // backgroundImage: NetworkImage(imageURL),
                    ),
                  )
              ),
              ListTile(
                leading: Icon(
                    CupertinoIcons.home,
                    color: Colors.white
                ),
                title: Text(
                    'Home',
                    textScaleFactor: 1.2,
                    style:TextStyle(color:Colors.white,),
                ),
              ),
              ListTile(
                leading: Icon(
                    CupertinoIcons.profile_circled,
                    color: Colors.white
                ),
                title: Text(
                  'Profile',
                  textScaleFactor: 1.2,
                  style:TextStyle(color:Colors.white,),
                ),
              ),
              ListTile(
                leading: Icon(
                    CupertinoIcons.mail,
                    color: Colors.white
                ),
                title: Text(
                  'Email',
                  textScaleFactor: 1.2,
                  style:TextStyle(color:Colors.white,),
                ),
              ),
            ]
        ),
      ),
    );
  }
}
