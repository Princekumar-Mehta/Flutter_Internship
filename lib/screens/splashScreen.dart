import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_2/Extras/myColors.dart';
import 'package:project_2/Extras/myScreen.dart';
import 'package:project_2/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacementNamed(
            context, MyRoutes.MyGetStartedScreen));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: MyColors.richBlackFogra,
          body: Center(
            child: Stack(children: [
              Positioned(
                top: MyScreen.getScreenHeight(context) / 5,
                left: MyScreen.getScreenWidth(context) / 3,
                child: Image.asset("assets/images/DIMS.png",
                    height: MyScreen.getScreenWidth(context) / 3,
                    width: MyScreen.getScreenWidth(context) / 3),
              ),
              Positioned(
                top: MyScreen.getScreenHeight(context) * (4 / 5),
                left: MyScreen.getScreenWidth(context) / 5,
                child: Image.asset("assets/images/Shivaay_Logo_Transparent.png",
                    height: MyScreen.getScreenHeight(context) / 5,
                    width: MyScreen.getScreenWidth(context) * (3 / 5)),
              )
            ]),
          )),
    );
  }
}
