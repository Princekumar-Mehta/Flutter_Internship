import 'package:flutter/material.dart';
import 'package:project_2/routes.dart';
import 'package:project_2/screens/splashScreen.dart';
import 'package:project_2/screens/loginScreen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MyRoutes.MYHome,
      routes: {
        MyRoutes.Mylogin : (context)=> LoginScreen(),
        MyRoutes.MYHome : (context)=> SplashScreen(),
      },
    );
  }
}
