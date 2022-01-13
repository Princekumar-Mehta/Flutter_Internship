import "package:flutter/material.dart";
import 'package:catalog_app/pages/login_page.dart';
import 'package:catalog_app/utils/routes.dart';
import 'package:catalog_app/widgets/themes.dart';
import 'pages/home_page.dart';

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
