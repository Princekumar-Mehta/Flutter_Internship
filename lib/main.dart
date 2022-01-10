import "package:flutter/material.dart";
import 'package:flutter_app_crash_course_2/pages/login_page.dart';
import 'package:flutter_app_crash_course_2/utils/routes.dart';
import 'package:flutter_app_crash_course_2/widgets/themes.dart';
import 'pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme(context),
      debugShowCheckedModeBanner: false,
      darkTheme : MyTheme.darkTheme(context) ,
        initialRoute: MyRoutes.loginRoute,
        routes:{
          MyRoutes.HomeRoute:(context)=>HomePage(),
          MyRoutes.loginRoute:(context)=>LoginPage(),
       },
    );

  }
}
