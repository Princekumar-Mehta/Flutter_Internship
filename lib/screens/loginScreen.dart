import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_2/Extras/myColors.dart';
import 'package:project_2/screens/signUp_Email.dart';
import 'package:project_2/screens/signUp_Google.dart';
import '../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoggedin = false;
  late GoogleSignInAccount _userObj ;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: MyColors.richBlackFogra,
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
                        color:MyColors.richBlackFogra,
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top:10,
                            left:20,
                            child:Text("Welcome!",style:TextStyle(color:MyColors.pewterBlue,fontSize: 30)),
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
                                  child:Text("Email/Employee ID *",style:TextStyle(color:MyColors.pewterBlue,fontSize: 20)),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width:300,
                                  height:20,
                                  child:TextFormField(
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:MyColors.pewterBlue)),
                                    ),
                                    style:TextStyle(color:MyColors.middleRed,fontSize: 20),
                                  ),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                    width:300,
                                    height:20,
                                    child: Row(
                                      children:[
                                        Text("Password *",style:TextStyle(color:MyColors.pewterBlue,fontSize: 20)),
                                        SizedBox(width:150),
                                        Icon(Icons.remove_red_eye,color:MyColors.pewterBlue,size:30),
                                      ],
                                    )
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                    width:300,
                                    height:30,
                                    child: Row(
                                      children:[
                                        SizedBox(
                                          width:300,
                                          height:20,
                                          child:TextFormField(
                                            obscureText:true,
                                            decoration: InputDecoration(
                                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:MyColors.pewterBlue)),
                                              // suffixIcon: Padding(
                                              //   padding: EdgeInsets.fromLTRB(0,0,0,40),
                                              //   child: Icon(Icons.remove_red_eye,color:MyColors.pewterBlue,size:30),
                                              // ),
                                            ),
                                            style:TextStyle(color:MyColors.middleRed,fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    )
                                ),

                                SizedBox(
                                    width:300,
                                    height:30,
                                    child: Row(
                                      children:[
                                        SizedBox(width: 130),
                                        Text("Forgot Password?",style:TextStyle(color:MyColors.middleRed,fontSize: 20)),
                                      ],
                                    )
                                ),
                                SizedBox(height:30),
                                SizedBox(
                                  width:300,
                                  height:30,
                                  child:  InkWell(
                                    child:Stack(
                                      children:[
                                        Opacity(
                                          opacity:0.6,
                                          child:Container(
                                            alignment:Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color:MyColors.scarlet,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child:Text("Login",style:TextStyle(color:Colors.white,fontSize: 17)),
                                        )
                                      ],
                                    ),

                                    onTap:(){Navigator.pushNamed(context,MyRoutes.MyGetStartedScreen);} ,
                                  ),
                                ),
                                SizedBox(height:20),
                                SizedBox(
                                  width:300,
                                  height:30,
                                  child:  InkWell(
                                    child:Stack(
                                      children:[
                                        Opacity(
                                          opacity:0.6,
                                          child:Container(
                                            alignment:Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color:MyColors.scarlet,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child:Text("Login with Google",style:TextStyle(color:Colors.white,fontSize: 17)),
                                        )
                                      ],
                                    ),
                                    onTap:(){Navigator.pushNamed(context,MyRoutes.MyGetStartedScreen);} ,
                                  ),
                                ),
                                Container(
                                  width:300,
                                  height:10,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color:MyColors.pewterBlue,
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
                                        color:MyColors.pewterBlue,
                                      ),
                                      child: InkWell(
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
                                        onTap:()=>Navigator.pushNamed(context, MyRoutes.MySignUpEmail)
                                      )
                                    ),
                                    SizedBox(width:20),
                                    Container(
                                      width: 120,
                                      height:50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        color:MyColors.pewterBlue,
                                      ),
                                      child:InkWell(
                                        child: Stack(
                                          children:[
                                            Positioned(
                                              left:10,
                                              top:8,
                                              child:Image.asset(
                                                "assets/images/Google_Logo.png",
                                                height:30,
                                                width:30,
                                              ),
                                            ),
                                            Positioned(
                                              right:10,
                                              top:15,
                                              child:Text("Sign Up",style:TextStyle(fontSize: 17)),
                                            ),
                                          ],
                                        ),
                                        onTap:(){
                                          // _googleSignIn.signOut().then((value){
                                          //   setState((){
                                          //     _isLoggedin = false;
                                          //     //_userObj = null!;
                                          //   });
                                          // }).catchError((e){
                                          //   print(e);
                                          // });
                                          _googleSignIn.signIn().then((userData){
                                            setState((){
                                              _isLoggedin = true;
                                              _userObj = userData!;
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpGoogle(user: userData,)));
                                            });
                                          }).catchError((e){
                                            print(e);
                                          });
                                        },
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
