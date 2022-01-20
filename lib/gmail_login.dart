import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './Insert_Data.dart';

class Gmail_Login extends StatefulWidget {
  const Gmail_Login({Key? key}) : super(key: key);

  @override
  _Gmail_Login_State createState() => _Gmail_Login_State();
}

class _Gmail_Login_State extends State<Gmail_Login> {
  bool _isLoggedin = false;
  late GoogleSignInAccount _userObj ;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar : AppBar(
          title:Text("Login Using Gmail"),
        ),
        body:Container(
          child: _isLoggedin ?
          Column(
              children: [
               // AddUser(_userObj.displayName.toString(),);
                Image.network(_userObj.photoUrl.toString()),
                Text(_userObj.displayName.toString()),
                Text(_userObj.email),
                TextButton(
                  onPressed : (){
                    _googleSignIn.signOut().then((value){
                      setState((){
                        _isLoggedin = false;
                        //_userObj = null!;
                      });
                    }).catchError((e){
                      print(e);
                    });
                  }, child: Text("Logout"),
                )
              ]
          ):
          Center(
            child: ElevatedButton(
              child: Text('Login with Gmail'),
              onPressed: (){
                _googleSignIn.signIn().then((userData){
                  setState((){
                    _isLoggedin = true;
                    _userObj = userData!;
                    AddData().addData(userData.displayName.toString(),userData.email,userData.photoUrl.toString());
                  });
                }).catchError((e){
                  print(e);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
