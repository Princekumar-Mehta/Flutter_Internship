import 'package:flutter/material.dart';
import 'package:intern_project_v1/routes.dart';
import 'package:intern_project_v1/screens/getStartedScreen.dart';
import 'package:intern_project_v1/screens/salesOrderScreen.dart';
import 'package:intern_project_v1/screens/signUp_Email.dart';
import 'package:intern_project_v1/screens/splashScreen.dart';
import 'package:intern_project_v1/screens/loginScreen.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home:SqliteApp(),
      initialRoute: MyRoutes.MyLogin,
      routes: {
        MyRoutes.MYSplashScreen : (context)=> SplashScreen(),
        MyRoutes.MyGetStartedScreen : (context)=> GetStartedScreen(),
        MyRoutes.MyLogin : (context)=> LoginScreen(),
        MyRoutes.MySignUpEmail : (context)=> SignUpEmail(),
        MyRoutes.MySalesOrder : (context)=> SalesOrderScreen(),
      },
    );
  }
}
