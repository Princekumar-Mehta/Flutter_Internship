import 'package:flutter/material.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  final int id;
  final int otp;
  const OtpVerificationScreen({Key? key, required this.email, required this.id,required this.otp}) : super(key: key);

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState(otp_mail:otp);
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final otp_user = TextEditingController();
  var otp_mail;
  _OtpVerificationScreenState(
      { required this.otp_mail}
      );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        body:Center(
          child: Row(
            children: [
              Container(
                width:300,
                height:30,
                child:TextFormField(
                  controller: otp_user,
                  decoration:InputDecoration(
                    label:Text("OTP"),
                    hintText:"Enter OTP",
                  ),
                ),
              ),
              FlatButton(
                  onPressed: (){
                    print(otp_mail);
                    print(otp_user.text.toString());
                  },
                  child: Text("Verify"),
              ),
            ],
          ),
        )
      )
    );
  }
}
