import "package:flutter/material.dart";
import 'package:flutter_app_crash_course_2/pages/login_page.dart';
import 'pages/home_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch : Colors.deepPurple,
      ),
      darkTheme : ThemeData(
        brightness: Brightness.dark,
      ),
        initialRoute: '/login',
        routes:{
          '/':(context)=>LoginPage(),
          '/home':(context)=>HomePage(),
          '/login':(context)=>LoginPage(),
       },
    );

  }
}
