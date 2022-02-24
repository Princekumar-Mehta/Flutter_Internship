import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_v3/Email/send_email.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';

import 'forgotPasswordScreen2.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  final int otp;
  final String previous;
  const OtpVerificationScreen(
      {Key? key,
      required this.email,
      required this.otp,
      required this.previous})
      : super(key: key);

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState(
      otp_mail: otp, email: email, previous: previous);
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final otp_user1 = TextEditingController();
  final otp_user2 = TextEditingController();
  final otp_user3 = TextEditingController();
  final otp_user4 = TextEditingController();
  FocusNode textFocusNode1 = new FocusNode();
  FocusNode textFocusNode2 = new FocusNode();
  FocusNode textFocusNode3 = new FocusNode();
  FocusNode textFocusNode4 = new FocusNode();
  var otp_mail;
  var email;
  var previous;
  _OtpVerificationScreenState(
      {required this.otp_mail, required this.email, required this.previous});
  Future<void> showMessage(
    BuildContext context,
    String message,
    String nextScreen,
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

  void clearAll() {
    otp_user1.clear();
    otp_user2.clear();
    otp_user3.clear();
    otp_user4.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: MyColors.richBlackFogra,
            body: Column(
              children: [
                SizedBox(
                    height: MyScreen.getScreenHeight(context) * (150 / 1063.6)),
                Container(
                  width: MyScreen.getScreenWidth(context),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (190 / 640),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (40 / 640),
                        height:
                            MyScreen.getScreenHeight(context) * (100 / 1063.6),
                        child: TextFormField(
                          style: TextStyle(
                            color: MyColors.scarlet,
                            fontSize: MyScreen.getScreenHeight(context) *
                                (22 / 1063.6),
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: MyColors.scarlet)),
                          ),
                          autofocus: true,
                          focusNode: textFocusNode1,
                          controller: otp_user1,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (String value) {
                            if (value.toString().length != 0) {
                              //print("go to 2");
                              otp_user1.text = otp_user1.text.toString()[0];
                              FocusScope.of(context)
                                  .requestFocus(textFocusNode2);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (30 / 640),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (40 / 640),
                        height:
                            MyScreen.getScreenHeight(context) * (100 / 1063.6),
                        child: TextFormField(
                          style: TextStyle(
                            color: MyColors.scarlet,
                            fontSize: MyScreen.getScreenHeight(context) *
                                (22 / 1063.6),
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: MyColors.scarlet)),
                          ),
                          focusNode: textFocusNode2,
                          controller: otp_user2,
                          keyboardType: const TextInputType.numberWithOptions(),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          onChanged: (String value) {
                            if (value.toString().length != 0) {
                              //print("go to 3");
                              otp_user2.text = otp_user2.text.toString()[0];
                              FocusScope.of(context)
                                  .requestFocus(textFocusNode3);
                            } else {
                              FocusScope.of(context)
                                  .requestFocus(textFocusNode1);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (30 / 640),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (40 / 640),
                        height:
                            MyScreen.getScreenHeight(context) * (100 / 1063.6),
                        child: TextFormField(
                          style: TextStyle(
                            color: MyColors.scarlet,
                            fontSize: MyScreen.getScreenHeight(context) *
                                (22 / 1063.6),
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: MyColors.scarlet)),
                          ),
                          focusNode: textFocusNode3,
                          controller: otp_user3,
                          keyboardType: const TextInputType.numberWithOptions(),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          onChanged: (String value) {
                            if (value.toString().length != 0) {
                              otp_user3.text = otp_user3.text.toString()[0];
                              //print("go to 4");
                              FocusScope.of(context)
                                  .requestFocus(textFocusNode4);
                            } else {
                              FocusScope.of(context)
                                  .requestFocus(textFocusNode2);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (30 / 640),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (40 / 640),
                        height:
                            MyScreen.getScreenHeight(context) * (100 / 1063.6),
                        child: TextFormField(
                          style: TextStyle(
                            color: MyColors.scarlet,
                            fontSize: MyScreen.getScreenHeight(context) *
                                (22 / 1063.6),
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: MyColors.scarlet)),
                          ),
                          focusNode: textFocusNode4,
                          controller: otp_user4,
                          keyboardType: const TextInputType.numberWithOptions(),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          onChanged: (String value) async {
                            //FocusScope.of(context).requestFocus(textFocusNode1);
                            if (value.toString().length != 0) {
                              otp_user4.text = otp_user4.text.toString()[0];
                              if (otp_user1.text.toString().length == 0 ||
                                  otp_user2.text.toString().length == 0 ||
                                  otp_user3.text.toString().length == 0 ||
                                  otp_user4.text.toString().length == 0) return;
                              final otp_user = otp_user1.text.toString() +
                                  otp_user2.text.toString() +
                                  otp_user3.text.toString() +
                                  otp_user4.text.toString();
                              if (otp_mail.toString() == otp_user) {
                                if (previous == "forgot password") {
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPasswordScreen2(
                                                email: email,
                                              )));
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              } else {
                                showMessage(context, "Wrong OTP", "none");
                                FocusScope.of(context)
                                    .requestFocus(textFocusNode1);
                              }
                              clearAll();
                            } else {
                              FocusScope.of(context)
                                  .requestFocus(textFocusNode3);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (195 / 640),
                    ),
                    TextButton(
                      onPressed: () {
                        clearAll();
                        FocusScope.of(context).requestFocus(textFocusNode1);
                      },
                      child: const Text("Reset"),
                    ),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (70 / 640),
                    ),
                    TextButton(
                      onPressed: () {
                        print(email);
                        otp_mail =
                            (1000 + Random().nextInt(9999 - 1000)).toString();
                        Send_Mail.send_mail(email, "OTP For Verification",
                            "OTP is:" + (otp_mail));
                        showMessage(context, "Resend OTP successful", "none");
                        clearAll();
                        FocusScope.of(context).requestFocus(textFocusNode1);
                      },
                      child: const Text("Resend"),
                    ),
                  ],
                ),
              ],
            )));
  }
}
