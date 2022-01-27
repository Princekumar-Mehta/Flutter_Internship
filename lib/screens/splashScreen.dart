import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_2/Extras/myColors.dart';
import 'package:project_2/routes.dart';
import 'package:project_2/screens/loginScreen.dart';

import 'getStartedScreen.dart';

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
    Timer(Duration(seconds: 5),
      ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GetStartedScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: MyColors.richBlackFogra,
          body: Center(
            child:Stack(
                children:[
                  Positioned(
                    top:MediaQuery.of(context).size.height/5,
                    left:MediaQuery.of(context).size.width/3,
                    child:Image.asset(
                        "assets/images/DIMS.png",
                        height:MediaQuery.of(context).size.width/3,
                        width:MediaQuery.of(context).size.width/3),
                  ),
                  Positioned(
                    top:MediaQuery.of(context).size.height*(4/5),
                    left:MediaQuery.of(context).size.width/5,
                    child:Image.asset(
                        "assets/images/Shivaay_Logo_Transparent.png",
                        height:MediaQuery.of(context).size.height/5,
                        width:MediaQuery.of(context).size.width*(3/5)),
                  )
                ]
            ),
          )
      ),
    );
  }
}
