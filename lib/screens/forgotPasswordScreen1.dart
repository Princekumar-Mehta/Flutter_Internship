import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_v3/Email/send_email.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/utility.dart';

import 'otpVerificationScreen.dart';

class ForgotPasswordScreen1 extends StatefulWidget {
  const ForgotPasswordScreen1({Key? key}) : super(key: key);
  @override
  _ForgotPasswordScreen1State createState() => _ForgotPasswordScreen1State();
}

class _ForgotPasswordScreen1State extends State<ForgotPasswordScreen1> {
  final email = TextEditingController();
  void showMessage(BuildContext context, String message,
      {bool moveToNextScreen = false}) {
    int otp;
    showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Alert'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Okay'),
            onPressed: () async => {
              Navigator.pop(c, false),
              if (moveToNextScreen)
                {
                  otp = 1000 + Random().nextInt(9999 - 1000),
                  Send_Mail.send_mail(email.text.toString(),
                      "OTP For Verification", "OTP is: " + otp.toString()),
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OtpVerificationScreen(
                                email: email.text.toString(),
                                otp: otp,
                                previous: "forgot password",
                              ))),
                }
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
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: MyColors.scarlet, size: 30),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          backgroundColor: MyColors.richBlackFogra,
        ),
        backgroundColor: MyColors.richBlackFogra,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height:
                            MyScreen.getScreenHeight(context) * (80 / 1063.6),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("Email Address *",
                            style: TextStyle(
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (50 / 1063.6),
                        child: TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: MyColors.pewterBlue)),
                          ),
                          style: TextStyle(
                              color: MyColors.middleRed,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (25 / 1063.6)),
                        ),
                      ),
                      SizedBox(
                        height:
                            MyScreen.getScreenHeight(context) * (680 / 1063.6),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (85 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (60 / 1063.6),
                        child: InkWell(
                          child: Stack(
                            children: [
                              Opacity(
                                opacity: 0.8,
                                child: Container(
                                  width: MyScreen.getScreenWidth(context) *
                                      (85 / 294),
                                  height: MyScreen.getScreenHeight(context) *
                                      (60 / 1063.6),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        MyScreen.getScreenHeight(context) *
                                            (10 / 1063.6)),
                                    color: MyColors.middleRed,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text("Submit",
                                    style: TextStyle(
                                        color: MyColors.richBlackFogra,
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (17 / 1063.6),
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                          onTap: () async {
                            if (email.text.toString().isEmpty) {
                              showMessage(context, "Please Enter Email ID");
                              return;
                            }
                            if (await Utility.isNotExist(
                                email.text.toString())) {
                              showMessage(context,
                                  "This is not a registered email address,\nPlease try again");
                              return;
                            } else {
                              showMessage(context,
                                  "A newly generated OTP has been sent to your email address.\n\nPlease take a look in your inbox, if it is not available there make sure to check your Spam folder. \n\nThank you.",
                                  moveToNextScreen: true);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
