import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_2/Extras/myColors.dart';
import 'package:project_2/Extras/myScreen.dart';
import 'package:project_2/routes.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  bool isStarted = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            title: const Text('Warning'),
            content: const Text('Do you really want to exit ?'),
            actions: [
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(c, true);
                  Navigator.pop(context);
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                },
              ),
              TextButton(
                child: const Text('No'),
                onPressed: () => Navigator.pop(c, false),
              ),
            ],
          ),
        );
        return Future.value(true);
      },
      child: Scaffold(
          backgroundColor: MyColors.richBlackFogra,
          body: Center(
            child: Stack(children: [
              Positioned(
                child: Container(
                  width: MyScreen.getScreenWidth(context),
                  height: MyScreen.getScreenHeight(context),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/images/Abstract_2.png"),
                    fit: BoxFit.fill,
                  )),
                ),
              ),
              Positioned(
                top: MyScreen.getScreenHeight(context) / (3.5),
                left: MyScreen.getScreenWidth(context) / 10.2,
                child: Image.asset("assets/images/DIMS.png",
                    height: MyScreen.getScreenWidth(context) / 3,
                    width: MyScreen.getScreenWidth(context) / 3),
              ),
              Positioned(
                bottom: MyScreen.getScreenHeight(context) * 0.027,
                left: MyScreen.getScreenWidth(context) * 0.45,
                child: InkWell(
                  onTap: () async {
                    await Future.delayed(const Duration(seconds: 2));
                    setState(() {
                      isStarted = true;
                    });
                    await Future.delayed(const Duration(seconds: 1));
                    await Navigator.pushNamed(context, MyRoutes.MyLogin);
                    await Navigator.pushNamed(
                        context, MyRoutes.MyGetStartedScreen);
                    setState(() {
                      isStarted = false;
                    });
                  },
                  child: Container(
                    width: MyScreen.getScreenWidth(context) * 0.44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFc8bdb1),
                      borderRadius: BorderRadius.circular(
                          MyScreen.getScreenHeight(context) * (5 / 553)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              MyScreen.getScreenHeight(context) * (5 / 553))),
                      child: Stack(
                        children: [
                          Container(
                            height: MyScreen.getScreenHeight(context) * 0.06,
                            width: isStarted
                                ? MyScreen.getScreenWidth(context) * 0.44
                                : MyScreen.getScreenWidth(context) * 0.17,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  MyScreen.getScreenHeight(context) *
                                      (5 / 553)),
                            ),
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 2),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MyScreen.getScreenWidth(context) * 0.02,
                                  ),
                                  Icon(Icons.person_add,
                                      color: MyColors.richBlackFogra,
                                      size: MyScreen.getScreenHeight(context) *
                                          0.035),
                                  SizedBox(
                                    width: isStarted
                                        ? MyScreen.getScreenWidth(context) *
                                            0.28
                                        : MyScreen.getScreenWidth(context) *
                                            0.01,
                                  ),
                                  Image.asset(
                                    "assets/images/Textered_Grip.png",
                                    height: MyScreen.getScreenHeight(context) *
                                        0.028,
                                    width:
                                        MyScreen.getScreenWidth(context) * 0.05,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right:
                                MyScreen.getScreenWidth(context) * (4 / 490.9),
                            top: MyScreen.getScreenHeight(context) *
                                (4 / 1063.6),
                            child: Opacity(
                              opacity: isStarted ? 0 : 1,
                              child: AnimatedContainer(
                                width: MyScreen.getScreenWidth(context) *
                                    (128 / 490.9),
                                height: MyScreen.getScreenHeight(context) *
                                    (58 / 1063.6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFc8bdb1),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                          MyScreen.getScreenHeight(context) *
                                              (5 / 553)),
                                      bottomRight: Radius.circular(
                                          MyScreen.getScreenHeight(context) *
                                              (5 / 553))),
                                ),
                                alignment: Alignment.center,
                                duration: const Duration(seconds: 2),
                                child: Text("Get Started",
                                    style: TextStyle(
                                        color: MyColors.richBlackFogra,
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (22 / 1063.6))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          )),
    );
  }
}
