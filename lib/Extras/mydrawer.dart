import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_Employee.dart';
import 'package:project_v3/Database/employee.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/screens/editEmployeeScreen.dart';

import '../routes.dart';

class MyDrawer extends StatelessWidget {
  static Employee emp = Employee();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xBFF42C04),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MyScreen.getScreenWidth(context) * (80 / 490.9),
                  height: MyScreen.getScreenWidth(context) * (80 / 490.9),
                  decoration: BoxDecoration(
                      color: MyColors.black,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(40))),
                  child: CircleAvatar(
                    radius: MyScreen.getScreenWidth(context) * (40 / 360),
                    backgroundImage: FileImage(File(emp.profile_pic!)),
                  ),
                ),
                Text(emp.name!),
                Text(emp.role!),
              ],
            ),
          ),
          ListTile(
            leading: MyDrawer.emp.darkTheme == 1
                ? const Icon(
                    Icons.brightness_4,
                  )
                : const Icon(
                    Icons.brightness_7,
                  ),
            iconColor: MyColors.scarlet,
            title: const Text('Theme'),
            onTap: () {
              if (MyDrawer.emp.darkTheme == 1) {
                MyColors().lightTheme();
                MyDrawer.emp.darkTheme = 0;
                Database_signUp().updateEmp(MyDrawer.emp);
              } else {
                MyColors().darkTheme();
                MyDrawer.emp.darkTheme = 1;
                Database_signUp().updateEmp(MyDrawer.emp);
              }
              Navigator.of(context)
                  .popUntil(ModalRoute.withName(MyRoutes.MyLogin));
              Navigator.pushReplacementNamed(context, MyRoutes.MyLogin);
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            iconColor: MyColors.scarlet,
            title: const Text('Home'),
            onTap: () {
              if (emp.role == "Admin") {
                Navigator.pushReplacementNamed(context, MyRoutes.MyAdminHome);
              } else if (emp.role == "Salesperson") {
                Navigator.pushReplacementNamed(
                    context, MyRoutes.MySalespersonHome);
              } else {
                Navigator.pushReplacementNamed(context, MyRoutes.MyManagerHome);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            iconColor: MyColors.scarlet,
            title: const Text('Profile'),
            onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditEmployeeScreen(
                            emp: MyDrawer.emp,
                          )));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            iconColor: MyColors.scarlet,
            title: const Text('Logout'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.of(context)
                  .popUntil(ModalRoute.withName(MyRoutes.MyLogin));
            },
          ),
          SizedBox(
            height: MyScreen.getScreenHeight(context) * (590 / 1063.6),
          ),
          Center(
            child: Column(
              children: const [
                Text('v 1.0.4'),
                Text('Developed by Shivaay Software Services'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
