import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_2/Email/send_email.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  final int id;
  final int otp;
  const OtpVerificationScreen(
      {Key? key, required this.email, required this.id, required this.otp})
      : super(key: key);

  @override
  _OtpVerificationScreenState createState() =>
      _OtpVerificationScreenState(otp_mail: otp, email: email);
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final otp_user = TextEditingController();
  var otp_mail;
  var email;
  _OtpVerificationScreenState({required this.otp_mail, required this.email});
  Future<void> showMessage(
    BuildContext context,
    String message,
  ) async {
    showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Alert'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Okay'),
            onPressed: () async {
              Navigator.pop(c, false);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              width: 300,
              height: 30,
              child: TextFormField(
                controller: otp_user,
                decoration: const InputDecoration(
                  label: Text("OTP"),
                  hintText: "Enter OTP",
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                ],
              ),
            ),
            FlatButton(
              onPressed: () {
                if (otp_mail.toString() == otp_user.text.toString())
                  showMessage(context, "Email Verification Successful");
                else {
                  showMessage(context, "Wong OTP");
                }
                print(otp_mail);
                print(otp_user.text.toString());
              },
              child: Text("Verify"),
            ),
            FlatButton(
              onPressed: () {
                print(email);
                otp_mail = (1000 + Random().nextInt(9999 - 1000)).toString();
                Send_Mail.send_mail(email, int.parse(otp_mail));
                showMessage(context, "Resend OTP successful");
                otp_user.clear();
              },
              child: Text("Resend"),
            ),
          ],
        ),
      ),
    )));
  }
}
