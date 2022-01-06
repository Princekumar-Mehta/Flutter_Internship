import "package:flutter/material.dart";

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar:AppBar(title:Text('Login Page')),
        body:
        Center(
          child:  Column(
            children: [
              Image.asset("assets/images/login_image.png"),
              SizedBox(height:20.0),
              Text('Welcome'),
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
                            hintText:"Enter Username",
                            labelText:"Username",
                          ),
                        ),
                        ElevatedButton(
                            child: Text('Enter'),
                            style:TextButton.styleFrom(backgroundColor: Colors.blue),
                            onPressed: (){
                              print("Enter Pressed");
                            },
                        )
                      ]
                  )
              )
            ]
          )
        )
      )
    );
  }
}
