import 'package:flutter/material.dart';

import '../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color(0xff0F1A20),
          body: Stack(
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
                    child: Center(
                      child:Opacity(
                        opacity:0.5,
                        child:Container(
                          width:MediaQuery.of(context).size.width,
                          height:MediaQuery.of(context).size.height,
                          color:Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Center(
                      child:Opacity(
                        opacity:1,
                        child:Container(
                          width:320,
                          height:500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color:Color(0xFF0F1A20),
                          ),
                          child: Stack(
                              children: [
                                Positioned(
                                  top:10,
                                  left:20,
                                  child:Text("Welcome!",style:TextStyle(color:Color(0xFF88A2AA),fontSize: 30)),
                                ),
                                Positioned(
                                  top:50,
                                  left:10,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 50),
                                      SizedBox(
                                        width:300,
                                        height:20,
                                        child:Text("Email/Employee ID *",style:TextStyle(color:Color(0xFF88A2AA),fontSize: 20)),
                                      ),
                                      SizedBox(height: 20),
                                      SizedBox(
                                        width:300,
                                        height:20,
                                        child:TextFormField(
                                          decoration: InputDecoration(
                                            hintText:'Full name',
                                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Color(0xFF88A2AA))),
                                          ),
                                          style:TextStyle(color:Color(0xFFE2856E),fontSize: 20),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      SizedBox(
                                          width:300,
                                          height:20,
                                          child: Row(
                                            children:[
                                              Text("Password *",style:TextStyle(color:Color(0xFF88A2AA),fontSize: 20)),
                                              SizedBox(width: 140),
                                              Icon(Icons.remove_red_eye,color:Color(0xFF88A2AA),size:30),
                                            ],
                                          )
                                      ),
                                      SizedBox(height: 20),
                                      SizedBox(
                                        width:300,
                                        height:20,
                                        child:TextFormField(
                                          obscureText:true,
                                          decoration: InputDecoration(
                                            hintText:'Enter Your Password',
                                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Color(0xFF88A2AA))),
                                            //suffixIcon:Icon(Icons.remove_red_eye,color:Color(0xFF88A2AA),size:30),
                                          ),
                                          style:TextStyle(color:Color(0xFFE2856E),fontSize: 20),

                                        ),
                                      ),
                                      SizedBox(
                                          width:300,
                                          height:30,
                                          child: Row(
                                            children:[
                                              SizedBox(width: 130),
                                              Text("Forgot Password?",style:TextStyle(color:Color(0xFFE2856E),fontSize: 20)),
                                            ],
                                          )
                                      ),
                                      SizedBox(height:30),
                                      SizedBox(
                                        width:300,
                                        height:30,
                                        child:  ElevatedButton(
                                          style:ElevatedButton.styleFrom(
                                            primary:Color(0xFFF42C04),
                                            shape:StadiumBorder(),
                                          ),
                                          child:Text("Login",style:TextStyle(fontSize:17)),
                                          onPressed:(){} ,
                                        ),
                                      ),
                                      SizedBox(height:20),
                                      SizedBox(
                                        width:300,
                                        height:30,
                                        child:  ElevatedButton(
                                          style:ElevatedButton.styleFrom(
                                            primary:Color(0xFFF42C04),
                                            shape:StadiumBorder(),
                                          ),
                                          child:Text("Login with Google",style:TextStyle(fontSize: 17)),
                                          onPressed:(){} ,
                                        ),
                                      ),
                                      Container(
                                        width:300,
                                        height:10,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color:Color(0xFF88A2AA),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height:20),
                                      Row(
                                        children:[
                                          Container(
                                            width: 120,
                                            height:50,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              color:Color(0xFF88A2AA),
                                            ),
                                            child:Stack(
                                              children:[
                                                Positioned(
                                                  left:7,
                                                  top:9,
                                                  child:Icon(Icons.mail,size: 35,),
                                                ),
                                                Positioned(
                                                  left:50,
                                                  top:15,
                                                  child:Text("Sign Up",style:TextStyle(fontSize: 17)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width:20),
                                          Container(
                                            width: 120,
                                            height:50,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              color:Color(0xFF88A2AA),
                                            ),
                                            child:Stack(
                                              children:[
                                                Positioned(
                                                  left:0,
                                                  top:0,
                                                  child:Image.asset(
                                                    "assets/images/DIMS.png",
                                                    height:50,
                                                    width:50,
                                                  ),
                                                ),
                                                Positioned(
                                                  left:50,
                                                  top:15,
                                                  child:Text("Sign Up",style:TextStyle(fontSize: 17)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                        ),
                      ),
                    ),
                  ),
                ]
            ),
      ),
    );
  }
}
