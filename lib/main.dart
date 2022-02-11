import 'package:flutter/material.dart';
import 'package:project_v3/routes.dart';
import 'package:project_v3/screens/forgotPasswordScreen1.dart';
import 'package:project_v3/screens/forgotPasswordScreen2.dart';
import 'package:project_v3/screens/loginScreen.dart';
import 'package:project_v3/screens/salesOrderScreen.dart';
import 'package:project_v3/screens/signUp_Email.dart';
import 'package:project_v3/screens/splashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoutes.MyLogin,
      routes: {
        MyRoutes.MYSplashScreen: (context) => SplashScreen(),
        MyRoutes.MyLogin: (context) => LoginScreen(),
        MyRoutes.MySignUpEmail: (context) => SignUpEmail(),
        MyRoutes.MySalesOrder: (context) => SalesOrderScreen(),
        MyRoutes.MyForgotPasswordScreen1: (context) => ForgotPasswordScreen1(),
        MyRoutes.MyForgotPasswordScreen2: (context) => ForgotPasswordScreen2(),
      },
    );
  }
}
