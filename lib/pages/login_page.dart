import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_app_crash_course_2/utils/routes.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  String name ="";
  bool changeButton = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar:AppBar(title:Text('Login Page')),
        body:
        SingleChildScrollView(
          child: Center(
              child:  Column(
                  children: [
                    Image.asset("assets/images/login_image.png"),
                    SizedBox(height:20.0),
                    Text("Welcome $name",style: TextStyle(fontSize: 30)),
                    SizedBox(height:20.0),
                    Padding(
                        padding : const EdgeInsets.symmetric(vertical:10.0,horizontal:10.0),
                        child: Column(
                            children :[
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText:"Enter Username",
                                  labelText:"Username",
                                ),
                                onChanged: (value){
                                  setState(() {
                                    name=value;
                                  });
                                },
                              ),
                              TextFormField(
                                obscureText:true,
                                decoration: InputDecoration(
                                  hintText:"Enter Password",
                                  labelText:"Password",
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    changeButton=true;
                                  });
                                  await Future.delayed(Duration(seconds:1));
                                  Navigator.pushNamed(context,MyRoutes.HomeRoute);
                                },
                                child:AnimatedContainer(
                                  //  onTap:
                                  duration: Duration(seconds:1),
                                  height: 50,
                                  width:changeButton?50:150,
                                  alignment: Alignment.center,
                                  child: changeButton?Icon(Icons.done):Text('Enter',style:TextStyle(color:Colors.white)),
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: changeButton?BorderRadius.circular(50):BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              // ElevatedButton(
                              //   child: Text('Enter'),
                              //   style:TextButton.styleFrom(backgroundColor: Colors.blue,minimumSize: Size(150,50)),
                              //   onPressed: (){
                              //
                              //     //  Navigator.pushNamed(context,MyRoutes.HomeRoute);
                              //   },
                              // )
                            ]
                        )
                    )
                  ]
              )
          )
        )
      )
    );
  }
}
