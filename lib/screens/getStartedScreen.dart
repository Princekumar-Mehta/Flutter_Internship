import 'package:flutter/material.dart';
import 'package:project_2/routes.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
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
                    right:MediaQuery.of(context).size.width/10,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(200,50),
                        primary: Colors.white,
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left:0,
                            child: Container(
                              width:30,
                              height:50,
                              child: Icon(Icons.person_add,color:Colors.black,size:40),
                            ),
                          ),
                          Positioned(
                            right:0,
                            child:
                            Container(
                              width:110,
                              height:50,
                              color:Color(0xFFced6d4),
                              alignment: Alignment.centerRight,
                              child: Text("Get Started",style:TextStyle(color:Colors.black,fontSize: 20)),
                            ),
                          ),
                        ],
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context,MyRoutes.MyLogin);
                      },
                    ),
                  ),
                ]
            ),
          )
      ),
    );
  }
}
