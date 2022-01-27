import 'package:flutter/material.dart';
import 'package:project_2/Extras/myColors.dart';

class SignUpGoogle extends StatefulWidget {
  const SignUpGoogle({Key? key}) : super(key: key);

  @override
  _SignUpGoogleState createState() => _SignUpGoogleState();
}

class _SignUpGoogleState extends State<SignUpGoogle> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration:BoxDecoration(
          color:MyColors.richBlackFogra,
        ),
      ),
    );
  }
}
