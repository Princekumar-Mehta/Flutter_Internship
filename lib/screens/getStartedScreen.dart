import 'package:flutter/material.dart';
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
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color(0xFF0F1A20),
          body: Center(
            child:Stack(
                children:[
                  Positioned(
                    child:Container(
                      width:MediaQuery.of(context).size.width,
                      height:MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image:AssetImage("assets/images/Abstract_2.png"),
                            fit:BoxFit.fill,
                          )
                      ),
                    ),
                  ),
                  Positioned(
                    top:MediaQuery.of(context).size.height/(3.5),
                    left:MediaQuery.of(context).size.width/10.2,
                    child:Image.asset(
                        "assets/images/DIMS.png",
                        height:MediaQuery.of(context).size.width/3,
                        width:MediaQuery.of(context).size.width/3),
                  ),
                  Positioned(
                    bottom:10,
                    left:160,
                    child:InkWell(
                      onTap:() async {
                        await Future.delayed(Duration(seconds:2));
                        setState(() {
                          isStarted=true;
                        });
                        await Future.delayed(Duration(seconds:1));
                        await  Navigator.pushNamed(context,MyRoutes.MyLogin);

                        },
                      child: Container(
                        width:170,
                        child:Stack(
                          children:[
                            Container(
                              height:50,
                              decoration: BoxDecoration(
                                color:Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: AnimatedContainer(
                                duration:  Duration(seconds:2),
                                child:Row(
                                  children: [
                                    Icon(Icons.person_add,color:Colors.black,size:30),
                                    isStarted?SizedBox(width:110):SizedBox(width:5),
                                    Image.asset(
                                      "assets/images/Textered_Grip.png",
                                      height:20,
                                      width:20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right:0,
                              child:Opacity(
                                opacity: isStarted?0:0.5,
                                child:AnimatedContainer(
                                  width:115,
                                  height:50,
                                  decoration: BoxDecoration(
                                    color:Color(0xFFced6d4),
                                    boxShadow:[BoxShadow(
                                      color:Colors.black,
                                      blurRadius: 10,
                                      offset:Offset(0, 2),
                                    ),
                                    ],
                                  ),
                                  alignment: Alignment.centerRight,
                                  duration:  Duration(seconds:2),
                                  child: Text("Get Started",style:TextStyle(color:Colors.black,fontSize: 22)),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),
                  ),
                ]
            ),
          )
      ),
    );
  }
}
