import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // final imageUrl ="https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60";
    final imageURL ="assets/images/login_image.png";
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
                    accountEmail:Text('PrinceMehta@gmail.com'),
                    currentAccountPicture: CircleAvatar(
                       //   backgroundImage: NetworkImage(imageUrl), // network issue
                     backgroundImage: AssetImage(imageURL),
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
