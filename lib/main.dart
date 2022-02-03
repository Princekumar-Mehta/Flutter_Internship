// import 'package:project_2/DatabaseManager/databaseManager.dart';
//
// main(){
//   DatabaseManager db = DatabaseManager();
//
// }
import 'package:flutter/material.dart';
import 'package:project_2/routes.dart';
import 'package:project_2/screens/getStartedScreen.dart';
import 'package:project_2/screens/salesOrderScreen.dart';
import 'package:project_2/screens/signUp_Google.dart';
import 'package:project_2/screens/signUp_Email.dart';
import 'package:project_2/screens/splashScreen.dart';
import 'package:project_2/screens/loginScreen.dart';
import 'package:project_2/temp/sqlite_app.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home:SqliteApp(),
      initialRoute: MyRoutes.MYSplashScreen,
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
