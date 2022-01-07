import "package:flutter/material.dart";
import 'package:flutter_app_crash_course_2/utils/routes.dart';

class LoginPage extends StatelessWidget {
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
                    Text('Welcome',style: TextStyle(fontSize: 30)),
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
                              ElevatedButton(
                                child: Text('Enter'),
                                style:TextButton.styleFrom(backgroundColor: Colors.blue,minimumSize: Size(150,50)),
                                onPressed: (){
                                    Navigator.pushNamed(context,MyRoutes.HomeRoute);
                                },
                              )
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
