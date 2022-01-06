import "package:flutter/material.dart";

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar:AppBar(title:Text('Login Page')),
        body:
        Center(
          child:Text('Login Page',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color:Colors.purple,
              ) ),
        )
      )
    );
  }
}
