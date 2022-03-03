import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:project_v3/Database/database_helper.dart';
import 'package:project_v3/Database/db_Employee.dart';
import 'package:project_v3/Database/employee.dart';
import 'package:project_v3/Email/send_email.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/utility.dart';

import '../routes.dart';
import 'otpVerificationScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Employee? emp;
  int? otp;
  final _formKey = GlobalKey<FormBuilderState>();
  void showMessage(BuildContext context, String message,
      {bool forcedPassword = false}) {
    showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Alert'),
        content: Text(message),
        actions: [
          TextButton(
              child: const Text('Okay'),
              onPressed: () async => {
                    if (forcedPassword)
                      {
                        otp = 1000 + Random().nextInt(9999 - 1000),
                        Send_Mail.send_mail(
                            emp!.email.toString(),
                            "OTP For Verification",
                            "OTP is: " + otp.toString()),
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpVerificationScreen(
                                      email: emp!.email.toString(),
                                      otp: otp!,
                                      previous: "forgot password",
                                    ))),
                        Navigator.pop(c, false),
                      }
                    else
                      {
                        Navigator.pop(c, false),
                      }
                  }),
        ],
      ),
    );
  }

  moveToHome(BuildContext context) async {
    DatabaseHelper.instance.insertAdminIfNot();
    await Database_signUp.print_emps();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      RegExp _numeric = RegExp(r'^-?[0-9]+$');
      String? id = _formKey.currentState?.value['email_or_id'].toString();
      if (await Utility.isNotExist(id.toString())) {
        showMessage(
            context, "This is not a registered email\nPlease Try again");
        return;
      } else {
        emp = await Utility.getEmployee(id.toString());
      }
      print(emp!.password);
      if (_formKey.currentState?.value['password'].toString() !=
          emp!.password) {
        showMessage(context, 'Wrong Password');
        return;
      } else if (_formKey.currentState?.value['password'].toString() ==
              emp!.password &&
          emp!.password == 'Dims@123') {
        showMessage(context, "Please reset your password to proceed further.",
            forcedPassword: true);
        _formKey.currentState!.reset();
      } else {
        MyDrawer.emp = emp!;
        await Future.delayed(const Duration(seconds: 1));
        if (emp!.role == "Admin") {
          await Navigator.pushNamed(context, MyRoutes.MyAdminHome);
        } else {
          await Navigator.pushNamed(context, MyRoutes.MySalesOrder);
        }
        _formKey.currentState!.reset();
      }
      /*MyDrawer.emp = emp;
      await Future.delayed(const Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.MyAdminHome);
      _formKey.currentState!.reset();*/
    }
  }

  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: MyColors.richBlackFogra,
          body: SizedBox(
            width: MyScreen.getScreenWidth(context),
            height: MyScreen.getScreenHeight(context),
            child: Stack(children: [
              Positioned(
                child: Center(
                  child: Opacity(
                    opacity: 1,
                    child: Container(
                      width: MyScreen.getScreenWidth(context) * (260 / 294),
                      height: MyScreen.getScreenHeight(context) * (290 / 553),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                            MyScreen.getScreenHeight(context) * (5 / 553))),
                        color: MyColors.white,
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: MyScreen.getScreenHeight(context) * 0.02,
                            left: MyScreen.getScreenWidth(context) * 0.05,
                            child: Text("Welcome!",
                                style: TextStyle(
                                    color: MyColors.black,
                                    fontSize:
                                        MyScreen.getScreenHeight(context) *
                                            (30 / 1063.6))),
                          ),
                          Positioned(
                            top: MyScreen.getScreenHeight(context) *
                                (140 / 1063.6),
                            left: MyScreen.getScreenWidth(context) * 0.05,
                            child: FormBuilder(
                              key: _formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: MyScreen.getScreenWidth(context) *
                                        (228 / 294),
                                    height: MyScreen.getScreenHeight(context) *
                                        (30 / 1063.6),
                                    child: Text("Email/Employee ID *",
                                        style: TextStyle(
                                            color: MyColors.black,
                                            fontSize: MyScreen.getScreenHeight(
                                                    context) *
                                                (20 / 1063.6))),
                                  ),
                                  SizedBox(
                                    width: MyScreen.getScreenWidth(context) *
                                        (228 / 294),
                                    height: MyScreen.getScreenHeight(context) *
                                        (50 / 1063.6),
                                    child: FormBuilderTextField(
                                        name: 'email_or_id',
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: MyColors.black)),
                                        ),
                                        style: TextStyle(
                                            color: MyColors.black,
                                            fontSize: MyScreen.getScreenHeight(
                                                    context) *
                                                (25 / 1063.6)),
                                        validator: (value) {
                                          RegExp regexem = RegExp(
                                              r'^[a-z0-9!#$%&"*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&"*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9][a-zA-Z0-9-]{0,253}\.)*[a-zA-Z0-9][a-zA-Z0-9-]{0,253}\.[a-zA-Z0-9]{2,}$');
                                          RegExp _numeric =
                                              RegExp(r'^-?[0-9]+$');
                                          if (value == null || value.isEmpty) {
                                            return "Please enter Email or Employee ID";
                                          } else if (!_numeric
                                              .hasMatch(value)) {
                                            if (!regexem.hasMatch(value)) {
                                              return "Enter Proper Email ID";
                                            }
                                          }
                                          return null;
                                        }),
                                  ),
                                  SizedBox(
                                      height:
                                          MyScreen.getScreenHeight(context) *
                                              (6 / 553)),
                                  SizedBox(
                                      width: MyScreen.getScreenWidth(context) *
                                          (228 / 294),
                                      height:
                                          MyScreen.getScreenHeight(context) *
                                              (30 / 1063.6),
                                      child: Row(
                                        children: [
                                          Text("Password *",
                                              style: TextStyle(
                                                  color: MyColors.black,
                                                  fontSize:
                                                      MyScreen.getScreenHeight(
                                                              context) *
                                                          (20 / 1063.6))),
                                        ],
                                      )),
                                  SizedBox(
                                    width: MyScreen.getScreenWidth(context) *
                                        (228 / 294),
                                    height: MyScreen.getScreenHeight(context) *
                                        (50 / 1063.6),
                                    child: FormBuilderTextField(
                                        name: 'password',
                                        obscureText: _isObscure,
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: MyColors.black)),
                                          suffixIcon: IconButton(
                                            padding: const EdgeInsets.only(
                                                bottom: 2.0),
                                            icon: Icon(
                                                _isObscure
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: MyColors.black,
                                                size: MyScreen.getScreenHeight(
                                                        context) *
                                                    (22 / 1063.6)),
                                            onPressed: () {
                                              setState(() {
                                                _isObscure = !_isObscure;
                                              });
                                            },
                                          ),
                                        ),
                                        style: TextStyle(
                                            color: MyColors.black,
                                            fontSize: MyScreen.getScreenHeight(
                                                    context) *
                                                (25 / 1063.6)),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please enter Password";
                                          }
                                          return null;
                                        }),
                                  ),
                                  Container(
                                    width: MyScreen.getScreenWidth(context) *
                                        (233 / 294),
                                    alignment: Alignment.centerRight,
                                    height: MyScreen.getScreenHeight(context) *
                                        (30 / 683.4285714285714),
                                    child: TextButton(
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                            color: MyColors.scarlet,
                                            fontSize: MyScreen.getScreenHeight(
                                                    context) *
                                                (17 / 1063.6)),
                                      ),
                                      onPressed: () => Navigator.pushNamed(
                                          context,
                                          MyRoutes.MyForgotPasswordScreen1),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MyScreen.getScreenHeight(context) *
                                              (80 / 1063.6)),
                                  SizedBox(
                                    width: MyScreen.getScreenWidth(context) *
                                        (228 / 294),
                                    height: MyScreen.getScreenHeight(context) *
                                        (60 / 1063.6),
                                    child: InkWell(
                                      child: Stack(
                                        children: [
                                          Opacity(
                                            opacity: 0.7,
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(MyScreen
                                                            .getScreenHeight(
                                                                context) *
                                                        (15 / 553)),
                                                color: MyColors.scarlet,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Text("Login",
                                                style: TextStyle(
                                                    color: MyColors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: MyScreen
                                                            .getScreenHeight(
                                                                context) *
                                                        (11 / 553))),
                                          )
                                        ],
                                      ),
                                      onTap: () => moveToHome(context),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MyScreen.getScreenHeight(context) *
                                              (10 / 1063.6)),
                                  // Text(
                                  //   'or',
                                  //   style: TextStyle(
                                  //     fontWeight: FontWeight.bold,
                                  //     fontSize:
                                  //         MyScreen.getScreenHeight(context) *
                                  //             (20 / 1063.6),
                                  //     color: MyColors.black,
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //     height:
                                  //         MyScreen.getScreenHeight(context) *
                                  //             (10 / 1063.6)),
                                  // SizedBox(
                                  //     height:
                                  //         MyScreen.getScreenHeight(context) *
                                  //             (10 / 1063.6)),
                                  // Row(
                                  //   children: [
                                  //     Container(
                                  //         width:
                                  //             MyScreen.getScreenWidth(context) *
                                  //                 (228 / 294),
                                  //         height: MyScreen.getScreenHeight(
                                  //                 context) *
                                  //             (45 / 1063.6),
                                  //         decoration: BoxDecoration(
                                  //           borderRadius: BorderRadius.circular(
                                  //               MyScreen.getScreenHeight(
                                  //                       context) *
                                  //                   (5 / 553)),
                                  //           color: MyColors.black,
                                  //         ),
                                  //         child: InkWell(
                                  //             child: Stack(
                                  //               children: [
                                  //                 Container(
                                  //                   width:
                                  //                       MyScreen.getScreenWidth(
                                  //                               context) *
                                  //                           (50 / 490.9),
                                  //                   height: MyScreen
                                  //                           .getScreenHeight(
                                  //                               context) *
                                  //                       (45 / 1063.6),
                                  //                   alignment: Alignment.center,
                                  //                   child: Icon(
                                  //                     Icons.account_circle,
                                  //                     size: MyScreen
                                  //                             .getScreenWidth(
                                  //                                 context) *
                                  //                         (35 / 490.9),
                                  //                     color: MyColors.white,
                                  //                   ),
                                  //                 ),
                                  //                 SizedBox(
                                  //                   width:
                                  //                       MyScreen.getScreenWidth(
                                  //                               context) *
                                  //                           (130 / 490.9),
                                  //                 ),
                                  //                 Center(
                                  //                   child: Text("Sign Up",
                                  //                       style: TextStyle(
                                  //                           color:
                                  //                               MyColors.white,
                                  //                           fontWeight:
                                  //                               FontWeight.bold,
                                  //                           fontSize: MyScreen
                                  //                                   .getScreenHeight(
                                  //                                       context) *
                                  //                               (11 / 553))),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //             onTap: () => Navigator.pushNamed(
                                  //                 context,
                                  //                 MyRoutes.MySignUpEmail))),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          )),
    );
  }
}
